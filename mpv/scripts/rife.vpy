import vapoursynth as vs
from vapoursynth import core
import vsmlrt

clip = video_in

# 分辨率向上取整至 64 的倍数
# 若需向下取整, 改为 (clip.width // 64) * 64
pad_w = ((clip.width + 63) // 64) * 64
pad_h = ((clip.height + 63) // 64) * 64

# 调整分辨率并转换为 RIFE 所需的 RGBS 格式
clip = core.resize.Bicubic(
    clip,
    width=pad_w,
    height=pad_h,
    format=vs.RGBS,
    matrix_in_s="709"
)

# 配置 TensorRT 后端
trt_backend = vsmlrt.Backend.TRT(
    device_id=0,         # 显卡序号 (GPU Index), 0 为第一张显卡
    workspace=None,      # 显存 (VRAM) 分配大小, None 为自动分配
    num_streams=2,       # CUDA 流并发数 (Number of Streams)
    max_aux_streams=2,   # 最大辅助流数 (Max Auxiliary Streams)
    fp16=True,           # 启用半精度浮点 (FP16) 加速 (提升性能但轻微降质)
    force_fp16=True,     # 强制使用 FP16 精度
    use_cuda_graph=True  # 启用 CUDA 图降低运行开销
    # use_cublas=True,                  # 优化矩阵运算
    # use_cudnn=True,                   # 优化卷积神经网络
    # use_edge_mask_convolutions=True,  # 减少模糊重影 (会降低性能)
    # use_jit_convolutions=True,        # 即时编译卷积 (增加编译时间, 提升运行性能)
    # static_shape=True,                # 静态形状 (增加编译时间, 提升运行性能)
    # heuristic=True,                   # TRT 自动选择最佳算法
    # short_path=True,                  # 短路径优化 (减少重复计算)
    # builder_optimization_level=5,     # 构建器优化等级 (0~5)
    # tiling_optimization_level=2       # 平铺优化等级 (0~2)
)

# 运行 RIFE 模型
clip = vsmlrt.RIFE(
    clip,
    model=46,            # 模型版本
    multi=2,             # 补帧倍速
    backend=trt_backend
)

# 恢复为常规的 YUV420P10 格式输出
clip = core.resize.Bicubic(
    clip,
    format=vs.YUV420P10,
    matrix_s="709"
)

clip.set_output()
