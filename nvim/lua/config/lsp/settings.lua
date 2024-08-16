local cmplsp = require("cmp_nvim_lsp")
local win_opts = require("config.lsp.win_opts")
local lsp_file_operations = require("lsp-file-operations")

local M = {}

local capabilities = vim.lsp.protocol.make_client_capabilities()
local cmp_capabilities = cmplsp.default_capabilities(capabilities)
local file_operation_capabilities = lsp_file_operations.default_capabilities()

M.capabilities = vim.tbl_deep_extend(
  "force",
  {},
  capabilities,
  cmp_capabilities,
  file_operation_capabilities,
  {
    workspace = {
      workspaceEdit = {
        documentChanges = true,
      },
    },
  }
)

local lsp_diagnostics = vim.lsp.diagnostic
local lsp_with = vim.lsp.with
local lsp_handlers = vim.lsp.handlers

M.handlers = vim.tbl_deep_extend("force", lsp_handlers, {
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
    -- are we renaming namespace?
    -- it also should be clojure only btw
    local _, rename_data, ctx = ...
    local filetype =
      vim.api.nvim_get_option_value("filetype", { buf = ctx.bufnr })
    if filetype == "clojure" then
      local doc_changes = rename_data.documentChanges[1]
      if doc_changes and doc_changes.kind == "rename" then
        -- ok we are renaming namespace
        -- construct data (emulate neo-tree rename call)
        local data = {
          old_name = vim.uri_to_fname(doc_changes.oldUri),
          new_name = vim.uri_to_fname(doc_changes.newUri),
        }
        require("lsp-file-operations.will-rename").callback(data)
        require("lsp-file-operations.did-rename").callback(data)
      end
    end
    -- call regular handler
    lsp_handlers["textDocument/rename"](...)

    vim.defer_fn(function()
      vim.cmd("wa")
    end, 200)
  end,
})

return M
