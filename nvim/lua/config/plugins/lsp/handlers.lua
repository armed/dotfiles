local opts = require('config.plugins.lsp.opts')

local M = {}

M.handlers = {
  ['textDocument/publishDiagnostics'] = vim.lsp.with(
    vim.lsp.diagnostic.on_publish_diagnostics,
    {
      virtual_text = false,
      signs = true,
      underline = true,
      update_in_insert = false,
      severity_sort = true
    }
  ),
  ['textDocument/codeLens'] = vim.lsp.with(
    vim.lsp.diagnostic.on_publish_diagnostics,
    { virtual_text = true }
  ),
  ['textDocument/hover'] = vim.lsp.with(
    vim.lsp.handlers.hover,
    opts.float_opts
  ),
  ['textDocument/signatureHelp'] = vim.lsp.with(
    vim.lsp.handlers.signature_help,
    opts.float_opts
  )
}

vim.api.nvim_create_augroup('LspGroup', { clear = true })
local function setup_codelens(_, bufnr)
  vim.lsp.codelens.refresh()
  vim.api.nvim_create_autocmd(
    { 'BufWritePost' },
    {
      group = 'LspGroup',
      buffer = bufnr,
      callback = vim.lsp.codelens.refresh
    })
end

function M.on_attach(client, bufnr)
  if client.server_capabilities.codeLensProvider then
    setup_codelens(client, bufnr)
  end
  require('which-key').register(opts.bindings, { noremap = true, buffer = bufnr })
end

return M
