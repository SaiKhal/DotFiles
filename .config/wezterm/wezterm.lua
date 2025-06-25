local wezterm = require("wezterm")

return {
	-- Font
	font = wezterm.font("JetBrains Mono"),
	font_size = 14.0,

	-- Color
	color_scheme = "Kanagawa (Gogh)",
	colors = colors,
	window_frame = window_frame, -- needed only if using fancy tab bar

	-- Window
	window_decorations = "RESIZE", -- Disable title bar but enable resizable border
	enable_scroll_bar = false,
	use_fancy_tab_bar = false,
	show_new_tab_button_in_tab_bar = false,
	hide_tab_bar_if_only_one_tab = true,
	initial_rows = 120,
	initial_cols = 350, -- Determines window size (fullscreen)
	window_padding = {
		left = "10px",
		right = "10px",
		top = "10px",
		bottom = 0,
	},

	-- Cursor
	cursor_blink_rate = 500,
	default_cursor_style = "BlinkingBlock",
	cursor_blink_ease_in = "Constant",
	cursor_blink_ease_out = "Constant",

	-- ssh_domains = ssh_domains,
}
