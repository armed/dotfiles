---@diagnostic disable: missing-fields
return {
  "rebelot/kanagawa.nvim",
  priority = 1000,
  config = function()
    local theme = require("kanagawa")

    theme.setup({
      dimInactive = true,
      commentStyle = {
        italic = false,
      },
      colors = {
        theme = {
          all = {
            ui = {
              bg_gutter = "none",
            },
          },
        },
      },
      keywordStyle = {
        italic = false,
      },
      globalStatus = true,
      overrides = function(colors)
        local palette = colors.palette

        vim.api.nvim_set_hl(0, "user.win.title", {
          bg = palette.crystalBlue,
          fg = palette.dragonBlack1,
        })

        return {
          WinSeparator = {
            fg = palette.lotusOrange2,
            bg = palette.bg_dim or "NONE",
          },
          IndentBlanklineChar = { fg = palette.bg_light2 },
          IndentBlanklineSpaceChar = { fg = palette.bg_light2 },
          IndentBlanklineSpaceCharBlankline = { fg = palette.bg_light2 },
          IndentBlanklineContextChar = { fg = palette.bg_light3 },
          IndentBlanklineContextStart = {
            sp = palette.bg_light3,
            underline = true,
          },
          ["@lsp.type.keyword.clojure"] = {
            link = "@string.special.symbol",
          },
        }
      end,
    })
  end,
}
