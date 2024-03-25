local M = {}

M.signs = {
  [vim.diagnostic.severity.ERROR] = "",
  [vim.diagnostic.severity.WARN] = "",
  [vim.diagnostic.severity.INFO] = "",
  [vim.diagnostic.severity.HINT] = "",
}

local function setup_new()
  vim.diagnostic.config({
    virtual_text = {
      prefix = function(diagnostic)
        return M.signs[diagnostic.severity]
      end,
    },
    signs = {
      text = M.signs,
    },
  })
end

M.signs_legacy = {
  Error = "",
  Warn = "",
  Hint = "",
  Info = "",
}

local function setup_legacy()
  for type, icon in pairs(M.signs_legacy) do
    local hl = "DiagnosticSign" .. type
    vim.fn.sign_define(hl, { text = icon, texthl = hl, numhl = "" })
  end
end

if vim.version().minor == 9 then
  M.setup = setup_legacy
else
  M.setup = setup_new
end

return M
