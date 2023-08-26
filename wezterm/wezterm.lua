local wezterm = require("wezterm")

local config = wezterm.config_builder()

-- The filled in variant of the < symbol
local SOLID_LEFT_ARROW = wezterm.nerdfonts.pl_right_hard_divider

-- The filled in variant of the > symbol
local SOLID_RIGHT_ARROW = wezterm.nerdfonts.pl_left_hard_divider

return {
  font = wezterm.font("JetBrainsMono Nerd Font Mono"),
  -- window_decorations = 'RESIZE',
  enable_tab_bar = true,
  font_size = 14.0,
  tab_bar_at_bottom = true,
  hide_tab_bar_if_only_one_tab = true,
  color_scheme = "nightfox",
  force_reverse_video_cursor = true,
  cursor_thickness = "0.2cell",
  window_frame = {
    border_left_width = "0cell",
    border_right_width = "0cell",
    border_bottom_height = "0cell",
    border_top_height = "0cell",
  },
  -- window_decorations = 'NONE',
  window_padding = {
    left = "0cell",
    right = "0cell",
    top = "0cell",
    bottom = "0cell",
  },
  tab_bar_style = {
    active_tab_left = wezterm.format({
      { Background = { Color = "#0b0022" } },
      { Foreground = { Color = "#2b2042" } },
      { Text = SOLID_LEFT_ARROW },
    }),
    active_tab_right = wezterm.format({
      { Background = { Color = "#0b0022" } },
      { Foreground = { Color = "#2b2042" } },
      { Text = SOLID_RIGHT_ARROW },
    }),
    inactive_tab_left = wezterm.format({
      { Background = { Color = "#0b0022" } },
      { Foreground = { Color = "#1b1032" } },
      { Text = SOLID_LEFT_ARROW },
    }),
    inactive_tab_right = wezterm.format({
      { Background = { Color = "#0b0022" } },
      { Foreground = { Color = "#1b1032" } },
      { Text = SOLID_RIGHT_ARROW },
    }),
  },
}
