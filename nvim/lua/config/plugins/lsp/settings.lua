local wk = require('which-key')
local cmplsp = require('cmp_nvim_lsp')
local bindings = require('config.plugins.lsp.bindings')
local win_opts = require('config.plugins.lsp.win_opts')

local M = {}

local lsp_group = vim.api.nvim_create_augroup('LspGroup', { clear = true })
local function setup_codelens(_, bufnr)
  vim.lsp.codelens.refresh()
  vim.api.nvim_create_autocmd(
    { 'BufWritePost' },
    {
      group = lsp_group,
      buffer = bufnr,
      callback = vim.lsp.codelens.refresh
    })
end

local capabilities = vim.lsp.protocol.make_client_capabilities()

M.capabilities = cmplsp.default_capabilities(capabilities)
-- M.capabilities.textDocument.foldingRange = {
--   dynamicRegistration = false,
--   lineFoldingOnly = true,
-- }

function M.on_attach(client, bufnr)
  if client.server_capabilities.codeLensProvider then
    setup_codelens(client, bufnr)
  end
  local wk_bindings = bindings.setup(bufnr)
  wk.register(wk_bindings, { noremap = true, buffer = bufnr })
end

local vld = vim.lsp.diagnostic
local vlw = vim.lsp.with
local vlh = vim.lsp.handlers

M.handlers = {
  ['textDocument/publishDiagnostics'] = vlw(
    vld.on_publish_diagnostics,
    {
      virtual_text = false,
      signs = true,
      underline = true,
      update_in_insert = false,
      severity_sort = true
    }
  ),
  ['textDocument/codeLens'] = vlw(vld.on_publish_diagnostics, { virtual_text = true }
  ),
  ['textDocument/hover'] = vlw(vlh.hover, win_opts.float_opts),
  ['textDocument/signatureHelp'] = vlw(vlh.signature_help, win_opts.float_opts),
  ["workspace/diagnostic/refresh"] = function(_, _, ctx)
    local ns = vld.get_namespace(ctx.client_id)
    pcall(vim.diagnostic.reset, ns)
    return true
  end
}

return M
