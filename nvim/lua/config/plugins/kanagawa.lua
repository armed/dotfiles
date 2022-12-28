return {
  'rebelot/kanagawa.nvim',
  lazy = false,
  config = function()
    local theme = require 'kanagawa'
    local colors = require("kanagawa.colors").setup()
    local c = require 'kanagawa.color'

    theme.setup {
      dimInactive = true,
      commentStyle = {
        italic = false
      },
      keywordStyle = {
        italic = false
      },
      globalStatus = true,
      overrides = {
        WinSeparator = {
          fg = tostring(c(colors.roninYellow):lighten(0.6)),
          bg = colors.bg_dim or "NONE",
        },
        IndentBlanklineChar = { fg = colors.bg_light0 },
        IndentBlanklineSpaceChar = { fg = colors.bg_light0 },
        IndentBlanklineSpaceCharBlankline = { fg = colors.bg_light0 },
        IndentBlanklineContextChar = { fg = colors.bg_light1 },
        IndentBlanklineContextStart = {
          sp = colors.bg_light1,
          underline = true
        }
      }
    }

    vim.cmd [[ colo kanagawa ]]

    -- hl-group for incline
    vim.api.nvim_set_hl(0, '@text.note', {
      bg = colors.crystalBlue,
      fg = colors.bg_dark
    })
  end
}
