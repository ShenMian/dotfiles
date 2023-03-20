local wezterm = require("wezterm")
return {
	font = wezterm.font("CaskaydiaCove Nerd Font"),
	font_size = 12.0,
	color_scheme = "Tango (terminal.sexy)",
	initial_cols = 120,
	initial_rows = 30,
	window_padding = {
		left = 0,
		right = 0,
		top = 0,
		bottom = 0,
	},
	-- window_background_opacity = 0.93,
	hide_tab_bar_if_only_one_tab = true,
}
