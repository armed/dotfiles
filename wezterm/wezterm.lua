local wezterm = require("wezterm")
local mux = wezterm.mux
local theme = require("theme")
local tab = require("tab")

local config = wezterm.config_builder()
local act = wezterm.action

config.font = wezterm.font("JetBrainsMono Nerd Font Mono")
-- window_decorations = 'RESIZE',
config.font_size = 12.0
config.cursor_thickness = "0.1cell"
config.window_frame = {
  border_left_width = "0cell",
  border_right_width = "0cell",
  border_bottom_height = "0cell",
  border_top_height = "0cell",
}
-- window_decorations = 'NONE',
config.window_padding = {
  left = "0.3cell",
  right = "0.3cell",
  top = "0.3cell",
  bottom = "0cell",
}

config.window_decorations = "RESIZE"

config.force_reverse_video_cursor = true

theme.setup(config)
tab.setup(config)

config.color_scheme = "kanagawabones"

config.term = "wezterm"

wezterm.on("gui-attached", function(domain)
  -- maximize all displayed windows on startup
  local workspace = mux.get_active_workspace()
  for _, window in ipairs(mux.all_windows()) do
    if window:get_workspace() == workspace then
      window:gui_window():maximize()
    end
  end
end)

config.keys = {
  { key = "{", mods = "SHIFT|ALT", action = act.MoveTabRelative(-1) },
  { key = "}", mods = "SHIFT|ALT", action = act.MoveTabRelative(1) },
  {
    key = "/",
    mods = "SUPER",
    action = wezterm.action_callback(function(_, pane)
      local t = pane:tab()
      local panes = t:panes_with_info()
      if #panes == 1 then
        pane:split({
          direction = "Bottom",
          size = 0.4,
        })
      elseif not panes[1].is_zoomed then
        panes[1].pane:activate()
        t:set_zoomed(true)
      elseif panes[1].is_zoomed then
        t:set_zoomed(false)
        panes[2].pane:activate()
      end
    end),
  },
}

config.inactive_pane_hsb = {
  saturation = 0.7,
  brightness = 0.3,
}

return config
