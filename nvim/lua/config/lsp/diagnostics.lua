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
      end
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

M.setup = setup_new

return M
