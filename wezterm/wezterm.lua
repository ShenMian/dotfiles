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
config.initial_cols = 100
config.initial_rows = 30

config.enable_scroll_bar = true

config.warn_about_missing_glyphs = false

if wezterm.target_triple == "x86_64-pc-windows-msvc" then
	config.default_prog = { "powershell.exe", "-NoLogo" }
	config.default_cwd = "D:/Users/sms/Desktop"
	config.font_size = 12.0
end

local bar = wezterm.plugin.require("https://github.com/adriankarlen/bar.wezterm")
bar.apply_to_config(config, {
	modules = {
		cwd = {
			enabled = false,
		},
	},
})

return config
