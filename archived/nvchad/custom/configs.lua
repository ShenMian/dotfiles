local M = {}

M.ui = {
  statusline = {
    separator_style = "block", -- default/round/block/arrow
    overriden_modules = nil,
  },

  -- lazyload it when there are 1+ buffers
  tabufline = {
    enabled = true,
    lazyload = true,
    overriden_modules = nil,
  },
}

M.treesitter = {
  ensure_installed = {
    "vim",
    "html",
    "json",
    "toml",
    "markdown",
    "c",
    "cpp",
    "bash",
    "lua",
  },
}

M.masom = {
  ensure_installed = {
    -- lua stuff
    "lua-language-server",
    "stylua",

    -- c++
    "clangd",
    "clang-format",
    "cpplint",

    -- cmake
    "cmake-language-server",
    "cmakelang",

    -- markdown
    "markdownlint",

    -- shell
    "shfmt",
    "shellcheck",
  },
}

M.nvimtree = {
  open_on_setup = true,
  view = {
    side = "right",
  },
  git = {
    enable = true,
  },
  renderer = {
    highlight_git = true,
    icons = {
      show = {
        git = true,
      },
    },
  },
}

return M
