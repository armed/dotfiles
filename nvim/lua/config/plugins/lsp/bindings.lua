local win_opts = require("config.plugins.lsp.win_opts")
local tb = require("telescope.builtin")
local ts = require("nvim-treesitter.ts_utils")

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
  vim.keymap.set({ "n", "v" }, "<leader>lf", vim.lsp.buf.format, { desc = "Format" })
  return {
    g = {
      d = { ":FzfLua lsp_definitions jump_to_single_result=true<cr>", "Go to Definition" },
      i = { ":FzfLua lsp_implementations jump_to_single_result=true<cr>", "Go to Implementations" },
      r = { ":FzfLua lsp_references jump_to_single_result=true<cr>", "LSP Rerefences" },
      t = { ":FzfLua lsp_type_definitiona jump_to_single_result=true<cr>", "Type Definition" },
    },
    ["<leader>"] = {
      l = {
        r = { vim.lsp.buf.rename, "Rename" },
        R = { ":LspRestart<cr>", "Lsp Restart" },
        I = { ":LspInfo<cr>", "Lsp Info" },
        n = { diag_next, "Next Diagnostics" },
        N = { diag_prev, "Prev Diagnostics" },
        l = { diag_float, "Line Diagnostic" },
        c = {
          name = "Codelens",
          a = { vim.lsp.codelens.run, "Run Action" },
          r = { vim.lsp.codelens.refresh, "Refresh" },
          c = {
            function()
              vim.lsp.codelens.clear(nil, 0)
            end,
            "Clear",
          },
        },
        a = { vim.lsp.buf.code_action, "Code Actions" },
        s = { ":FzfLua lsp_document_symbols<cr>", "Document Symbols" },
        S = { ":FzfLua lsp_workspace_symbols<cr>", "Workspace Symbols" },
        d = { ":FzfLua lsp_document_diagnostics<cr>", "Document Diagnostics" },
        D = { ":FzfLua lsp_workspace_diagnostics<cr>", "Workspace Diagnostics" },
      },
    },
    K = { vim.lsp.buf.hover, "Hover doc" },
    -- ["<C-k>"] = { vim.lsp.buf.signature_help, "Signature Documentation" }
  }
end

return M
