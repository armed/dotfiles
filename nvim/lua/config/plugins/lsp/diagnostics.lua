local M = {}

M.signs = { Error = "", Warn = "", Hint = "", Info = "" }

function M.setup()
  for type, icon in pairs(M.signs) do
    local hl = "DiagnosticSign" .. type
    vim.fn.sign_define(hl, { text = icon, texthl = hl, numhl = "" })
  end
end

return M
