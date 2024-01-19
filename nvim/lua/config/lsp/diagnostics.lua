local M = {}

M.signs = {
  [vim.diagnostic.severity.ERROR] = "",
  [vim.diagnostic.severity.WARN] = "",
  [vim.diagnostic.severity.INFO] = "",
  [vim.diagnostic.severity.HINT] = "",
}

function M.setup()
  vim.diagnostic.config({
    virtual_text = {
      prefix = function(diagnostic)
        return M.signs[diagnostic.severity]
      end
    },
    signs = {
      text = M.signs,
    },
  })
end

return M
