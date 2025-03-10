local M = {}

M.signs = {
  [vim.diagnostic.severity.ERROR] = "✘",
  [vim.diagnostic.severity.WARN] = "⚠",
  [vim.diagnostic.severity.INFO] = "ℹ",
  [vim.diagnostic.severity.HINT] = "➤",
}

function M.setup()
  vim.diagnostic.config({
    virtual_text = false,
    signs = {
      text = M.signs,
    },
  })
end

return M
