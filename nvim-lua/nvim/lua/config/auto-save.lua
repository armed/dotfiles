local M = {}

function M.setup()
  local as = require("auto-save")

  as.setup {
    condition = function(buf)
      return vim.fn.getbufvar(buf, "&modifiable") == 1
    end
  }
end

return M
