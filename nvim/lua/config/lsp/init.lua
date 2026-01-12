require("config.lsp.diagnostics").setup()
require("config.lsp.autocmds").setup()

-- Custom rename handler that saves all files and refreshes current buffer
local original_rename_handler = vim.lsp.handlers["textDocument/rename"]
vim.lsp.handlers["textDocument/rename"] = function(...)
  local result = original_rename_handler(...)
  vim.cmd("wa")
  vim.defer_fn(function()
    vim.lsp.codelens.refresh()
  end, 300)
  return result
end
