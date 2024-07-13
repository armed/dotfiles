local cmplsp = require("cmp_nvim_lsp")
local win_opts = require("config.lsp.win_opts")

local M = {}

local capabilities = vim.lsp.protocol.make_client_capabilities()
local cmp_capabilities = cmplsp.default_capabilities(capabilities)

M.capabilities = vim.tbl_deep_extend("force", {}, capabilities, cmp_capabilities)

local lsp_diagnostics = vim.lsp.diagnostic
local lsp_with = vim.lsp.with
local lsp_handlers = vim.lsp.handlers

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
  ["textDocument/codeLens"] = lsp_with(
    lsp_diagnostics.on_publish_diagnostics,
    { virtual_text = true }
  ),
  -- ["textDocument/hover"] = lsp_with(lsp_handlers.hover, win_opts.float_opts),
  ["textDocument/signatureHelp"] = lsp_with(
    lsp_handlers.signature_help,
    win_opts.float_opts
  ),
  ["workspace/diagnostic/refresh"] = function(_, _, ctx)
    local ns = lsp_diagnostics.get_namespace(ctx.client_id, true)
    pcall(vim.diagnostic.reset, ns)
    return true
  end,
  ["textDocument/rename"] = function(...)
    lsp_handlers["textDocument/rename"](...)
    vim.cmd("wa")
  end
})

return M
