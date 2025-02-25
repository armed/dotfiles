local M = {}

M.signs = {
  [vim.diagnostic.severity.ERROR] = "✘",
  [vim.diagnostic.severity.WARN] = "⚠",
  [vim.diagnostic.severity.INFO] = "ℹ",
  [vim.diagnostic.severity.HINT] = "➤",
}

function M.setup(filetype)
  local vt
  if filetype ~= "rust" then
    vt = false
  else
    vt = {
      prefix = function(diagnostic)
        return M.signs[diagnostic.severity]
      end,
    }
  end
  vim.diagnostic.config({
    virtual_text = vt,
    signs = {
      text = M.signs,
    },
  })
end

return M
