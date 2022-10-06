local wezterm = require 'wezterm'

return {
  font = wezterm.font 'JetBrainsMono Nerd Font Mono',
  -- window_decorations = 'RESIZE',
  enable_tab_bar = false,
  font_size = 16.0,
  tab_bar_at_bottom = true,
  hide_tab_bar_if_only_one_tab = true,
  color_scheme = 'nightfox',
  force_reverse_video_cursor = true,
  cursor_thickness = '0.2cell',
  window_frame = {
    border_left_width = '0cell',
    border_right_width = '0cell',
    border_bottom_height = '0cell',
    border_top_height = '0cell',
  },
  -- window_decorations = 'NONE',
  window_padding = {
    left = '0cell',
    right = '0cell',
    top = '0cell',
    bottom = '0cell',
  }
}
