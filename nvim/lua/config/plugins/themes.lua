return {
  {
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
  },
  {
    "folke/tokyonight.nvim",
    lazy = true,
    opts = {
      style = "moon",
      dim_inactive = true,
      on_colors = function(colors)
        colors.diff.change = colors.cyan
      end,
      on_highlights = function(highlights, colors)
        highlights.WinSeparator = { fg = colors.orange }
      end,
    },
    config = function(params)
      local theme = require("tokyonight")
      theme.setup(params.opts)
      vim.cmd([[ colo tokyonight ]])

      local colors = require("tokyonight.colors")
      vim.api.nvim_set_hl(0, "user.win.title", {
        bg = colors.default.blue,
        fg = colors.default.bg_dark,
      })
    end,
  },
  {
    "zenbones-theme/zenbones.nvim",
    -- Optionally install Lush. Allows for more configuration or extending the colorscheme
    -- If you don't want to install lush, make sure to set g:zenbones_compat = 1
    -- In Vim, compat mode is turned on as Lush only works in Neovim.
    dependencies = "rktjmp/lush.nvim",
    lazy = false,
    priority = 1000,
    -- you can set set configuration options here
    -- config = function()
    --     vim.g.zenbones_darken_comments = 45
    --     vim.cmd.colorscheme('zenbones')
    -- end
  },
}
