local Theme = {}

function Theme.get_colors()
  return {
    rosewater = "#ff5d62",
    flamingo = "#f2cdcd",
    pink = "#f5c2e7",
    mauve = "#957fb8",
    red = "#c34043",
    maroon = "#eba0ac",
    peach = "#ffa066",
    yellow = "#c0a36e",
    green = "#76946a",
    teal = "#6a9589",
    sky = "#89dceb",
    sapphire = "#74c7ec",
    blue = "#7e9cd8",
    lavender = "#b4befe",
    text = "#c8c093",
    subtext1 = "#bac2de",
    subtext0 = "#a6adc8",
    overlay2 = "#c8c093",
    overlay1 = "#7f849c",
    overlay0 = "#6c7086",
    surface2 = "#c8c093",
    surface1 = "#45475a",
    surface0 = "#16161d",
    base = "#1f1f28",
    mantle = "#181825",
    crust = "#11111b",
  }
end

function Theme.setup(config)
  local colors = Theme.get_colors()

  config.colors = {
    tab_bar = {
      background = colors.base,
      active_tab = {
        bg_color = colors.surface0,
        fg_color = colors.subtext1,
        intensity = "Bold",
        underline = "None",
        italic = false,
        strikethrough = false,
      },
      inactive_tab = {
        bg_color = "none",
        fg_color = colors.surface2,
      },
      inactive_tab_hover = {
        bg_color = colors.base,
        fg_color = colors.subtext0,
      },
      new_tab = {
        bg_color = colors.base,
        fg_color = colors.subtext0,
      },
      new_tab_hover = {
        bg_color = colors.base,
        fg_color = colors.surface2,
      },
    },
  }
end

return Theme
