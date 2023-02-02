local M = {
  "catppuccin/nvim",
  enabled = false,
  name = "catppuccin",
}

function M.config()
  local cp = require("catppuccin")
  vim.cmd("hi link user.win.title @text.note")

  cp.setup({
    flavour = "mocha",
    integrations = {
      fidget = true,
      navic = { enabled = true },
    },
    background = {
      light = "latte",
      dark = "mocha",
    },
    dim_inactive = { enabled = true },
    color_overrides = {
      mocha = { surface2 = "#737487" },
    },
    custom_highlights = function(colors)
      return { VertSplit = { fg = colors.peach } }
    end,
  })
  vim.cmd.colorscheme("catppuccin")
end

return M
