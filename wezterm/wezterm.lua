local wezterm = require 'wezterm'

return {
  font = wezterm.font 'JetBrainsMono Nerd Font Mono',
  font_size = 16.0,
  tab_bar_at_bottom = true,
  hide_tab_bar_if_only_one_tab = true,
  color_scheme = 'nightfox',
  window_frame = {
    border_left_width = '0.5cell',
    border_right_width = '0.5cell',
    border_bottom_height = '0.25cell',
    border_top_height = '0.25cell',
  },
  -- window_decorations = 'NONE',
  window_padding = {
    left = 15,
    right = 15,
    top = 15,
    bottom = 0,
  }
}
