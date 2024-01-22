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
          ["@string.regexp"] = { link = "@string.regex" },
          ["@variable.parameter"] = { link = "@parameter" },
          ["@exception"] = { link = "@exception" },
          ["@string.special.symbol"] = { link = "@symbol" },
          ["@markup.strong"] = { link = "@text.strong" },
          ["@markup.italic"] = { link = "@text.emphasis" },
          ["@markup.heading"] = { link = "@text.title" },
          ["@markup.raw"] = { link = "@text.literal" },
          ["@markup.quote"] = { link = "@text.quote" },
          ["@markup.math"] = { link = "@text.math" },
          ["@markup.environment"] = { link = "@text.environment" },
          ["@markup.environment.name"] = { link = "@text.environment.name" },
          ["@markup.link.url"] = { link = "Special" },
          ["@markup.link.label"] = { link = "Identifier" },
          ["@comment.note"] = { link = "@text.note" },
          ["@comment.warning"] = { link = "@text.warning" },
          ["@comment.danger"] = { link = "@text.danger" },
          ["@diff.plus"] = { link = "@text.diff.add" },
          ["@diff.minus"] = { link = "@text.diff.delete" },
        }
      end,
    })
  end,
}
