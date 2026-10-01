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

          return {
            ["user.win.title"] = {
              bg = palette.crystalBlue,
              fg = palette.dragonBlack1,
            },
            WinSeparator = { fg = palette.lotusOrange2, bg = "NONE" },
            IblIndent = { fg = colors.theme.ui.nontext },
            IblWhitespace = { fg = colors.theme.ui.nontext },
            IblScope = { fg = palette.waveBlue1 },
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
        highlights["user.win.title"] = { bg = colors.blue, fg = colors.bg_dark }
      end,
    },
    config = function(_, opts)
      require("tokyonight").setup(opts)
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
