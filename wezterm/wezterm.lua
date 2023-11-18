local wezterm = require("wezterm")
local theme = require("theme")
local tab = require("tab")

local config = wezterm.config_builder()

config.font = wezterm.font("JetBrainsMono Nerd Font Mono")
-- window_decorations = 'RESIZE',
config.font_size = 14.0
config.cursor_thickness = "0.1cell"
config.window_frame = {
  border_left_width = "0cell",
  border_right_width = "0cell",
  border_bottom_height = "0cell",
  border_top_height = "0cell",
}
-- window_decorations = 'NONE',
config.window_padding = {
  left = "0cell",
  right = "0cell",
  top = "0cell",
  bottom = "0cell",
}

config.force_reverse_video_cursor = true

theme.setup(config)
tab.setup(config)

config.color_scheme = "kanagawabones"

return config
