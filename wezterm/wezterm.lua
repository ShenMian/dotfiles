local wezterm = require("wezterm")
local config = wezterm.config_builder()

config.font = wezterm.font("Cascadia Code NF")
config.font_size = 14.0

config.color_scheme = "Tango (terminal.sexy)"
config.window_background_opacity = 0.85
config.window_padding = {
	left = 0,
	right = 0,
	top = 0,
	bottom = 0,
}
config.initial_cols = 120
config.initial_rows = 30

config.enable_scroll_bar = true

if wezterm.target_triple == "x86_64-pc-windows-msvc" then
	config.default_prog = { "powershell.exe", "-NoLogo" }
end

return config
