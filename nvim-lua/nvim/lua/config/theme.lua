local M = {}

local configs = {
  nightfox = {
    options = { dim_inactive = true },
    groups = {
      nightfox = {
        VertSplit = { fg = "#a35400" }
      }
    }
  }
}

function M.setup()
  local theme = "nightfox"

  require(theme).setup(configs[theme])

  vim.cmd("colorscheme " .. theme)
end

return M
