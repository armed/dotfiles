local win_opts = require("config.lsp.win_opts")

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

function M.lsp_restart()
  vim.cmd("LspStop")
  vim.defer_fn(function()
    vim.cmd("e")
  end, 1000)
end

local function clojure_clean_restart_lsp()
  local ft = vim.bo.filetype
  if ft == "clojure" then
    local lsp_keymaps = require("config.lsp.keymaps")
    vim.fn.delete(".lsp/.cache", "rf")
    lsp_keymaps.lsp_restart()
  end
end

function M.setup()
  local conform = require("conform")
  vim.keymap.set({ "n", "v" }, "<leader>lf", function()
    local current_view = vim.fn.winsaveview()
    conform.format({ lsp_fallback = true })
    vim.fn.winrestview(current_view)
  end, { desc = "Format" })
  return {
    g = {
      d = { ":Telescope lsp_definitions<cr>", "Go to Definition" },
      i = { ":Telescope lsp_implementations<cr>", "Go to Impementations" },
      r = { ":Telescope lsp_references<cr>", "Symbol References" },
      t = { ":Telescope lsp_type_definitions<cr>", "Type Definitions" },
    },
    t = { ":Telescope lsp_type_definitions<cr>", "Type Definition" },
    ["<leader>"] = {
      l = {
        h = {
          function()
            if vim.lsp.inlay_hint then
              vim.lsp.inlay_hint(0)
            end
          end,
          "Inlay hints",
        },
        e = { "<cmd>e<cr>", "Edit" },
        C = { clojure_clean_restart_lsp, "LSP Clean Restart" },
        r = { vim.lsp.buf.rename, "Rename" },
        R = { M.lsp_restart, "Lsp Restart" },
        I = { "<cmd>LspInfo<cr>", "Lsp Info" },
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
        s = { ":Telescope lsp_document_symbols<cr>", "Document Symbols" },
        S = {
          ":Telescope lsp_dynamic_workspace_symbols<cr>",
          "Workspace Symbols",
        },
        d = {
          ":TroubleToggle document_diagnostics<cr>",
          "Document Diagnostics",
        },
        D = {
          ":TroubleToggle workspace_diagnostics<cr>",
          "Workspace Diagnostics",
        },
        w = {
          name = "LSP Workspace",
          a = { vim.lsp.buf.add_workspace_folder, "Workspace Add Folder" },
          r = { vim.lsp.buf.remove_workspace_folder, "Workspace Remove Folder" },
        },
        a = { vim.lsp.buf.code_action, "Code Actions" },
      },
      k = {
        function()
          require("conjure.eval")["doc-word"]()
        end,
        "Cojure hover doc",
      },
    },
    K = { vim.lsp.buf.hover, "Hover doc" },
  }
end

return M
