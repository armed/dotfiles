local M = {}

function M.get_lsp_clients(filter)
  local get_clients = vim.lsp.get_clients or vim.lsp.get_active_clients
  return get_clients(filter)
end

return M
