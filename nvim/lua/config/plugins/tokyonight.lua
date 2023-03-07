local M = {
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
  end,
}

M.init = function()
  vim.cmd([[ colo tokyonight ]])

  local colors = require("tokyonight.colors")
  vim.api.nvim_set_hl(0, "user.win.title", {
    bg = colors.default.blue,
    fg = colors.default.bg_dark,
  })
end

return M
-- local tc = require("tokyonight.theme")
-- local colors = require("tokyonight.colors")
