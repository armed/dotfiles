local cmplsp = require("cmp_nvim_lsp")
local win_opts = require("config.plugins.lsp.win_opts")

local M = {}

local capabilities = vim.lsp.protocol.make_client_capabilities()
capabilities.workspace.workspaceEdit.documentChanges = true
local cmp_capabilities = cmplsp.default_capabilities(capabilities)

M.capabilities = vim.tbl_deep_extend("force", capabilities, cmp_capabilities)

local lsp_diagnostics = vim.lsp.diagnostic
local lsp_with = vim.lsp.with
local lsp_handlers = vim.lsp.handlers

local orig_rename = vim.lsp.handlers["textDocument/rename"]

M.handlers = vim.tbl_deep_extend("force", vim.lsp.handlers, {
  ["textDocument/publishDiagnostics"] = lsp_with(
    lsp_diagnostics.on_publish_diagnostics,
    {
      virtual_text = false,
      signs = true,
      underline = true,
      update_in_insert = false,
      severity_sort = true,
    }
  ),
  ["textDocument/rename"] = function(a, result, ctx, b)
    orig_rename(a, result, ctx, b)
    -- save all modified files after rename and refresh codelens
    vim.schedule(function() vim.cmd("wa!") end)
    vim.defer_fn(vim.lsp.codelens.refresh, 2000)
  end,
  ["textDocument/codeLens"] = lsp_with(
    lsp_diagnostics.on_publish_diagnostics,
    { virtual_text = true }
  ),
  ["textDocument/hover"] = lsp_with(lsp_handlers.hover, win_opts.float_opts),
  ["textDocument/signatureHelp"] = lsp_with(
    lsp_handlers.signature_help,
    win_opts.float_opts
  ),
  ["workspace/diagnostic/refresh"] = function(_, result, ctx)
    print(vim.inspect(result), vim.inspect(ctx))
    local ns = lsp_diagnostics.get_namespace(ctx.client_id)
    pcall(vim.diagnostic.reset, ns)
    return true
  end,
})

return M
