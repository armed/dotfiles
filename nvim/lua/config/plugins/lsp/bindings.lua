local win_opts = require("config.plugins.lsp.win_opts")
local tb = require("telescope.builtin")

local function diag_next()
  vim.diagnostic.goto_next(win_opts)
end

local function diag_prev()
  vim.diagnostic.goto_prev(win_opts)
end

local function diag_float()
  vim.diagnostic.open_float(win_opts.float_opts)
end

local M = {}

function M.setup(bufnr)
  return {
    g = {
      d = { tb.lsp_definitions, "Go to Definition" },
      i = { tb.lsp_implementations, "Go to Impementations" },
      r = { function () tb.lsp_references { show_line = false } end, "LSP Rerefences" },
      t = { tb.lsp_type_definitions, "Type Definition" }
    },
    ["<leader>"] = {
      l = {
        r = { vim.lsp.buf.rename, "Rename" },
        n = { diag_next, "Next Diagnostics" },
        N = { diag_prev, "Prev Diagnostics" },
        l = { diag_float, "Line Diagnostic" },
        c = {
          name = "Codelens",
          a = { vim.lsp.codelens.run, "Run Action" },
          r = { vim.lsp.codelens.refresh, "Refresh" },
          c = { function () vim.lsp.codelens.clear(nil, 0) end, "Clear" }
        },
        a = { vim.lsp.buf.code_action, "Code Actions" },
        s = { tb.lsp_document_symbols, "Document Symbols" },
        S = { tb.lsp_dynamic_workspace_symbols, "Workspace Symbols" },
        f = { vim.lsp.buf.format, "Format Buffer" },
        d = { function() tb.diagnostics { bufnr = bufnr } end, "Document Diagnostics" },
        D = { tb.diagnostics, "Workspace Diagnostics" },
        w = {
          name = "LSP Workspace",
          a = { vim.lsp.buf.add_workspace_folder, "Workspace Add Folder" },
          r = { vim.lsp.buf.remove_workspace_folder, "Workspace Remove Folder" }
        }
      }
    },
    K = { vim.lsp.buf.hover, "Hover doc" },
    -- ["<C-k>"] = { vim.lsp.buf.signature_help, "Signature Documentation" }
  }
end

return M
