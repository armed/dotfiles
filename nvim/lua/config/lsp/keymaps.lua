local win_opts = require("config.lsp.win_opts")

local diag = vim.diagnostic
local diag_settings = require("config.lsp.diagnostics")

local function diag_next()
  vim.diagnostic.jump({ count = vim.v.count1 })
end

local function diag_prev()
  vim.diagnostic.jump({ count = -vim.v.count1 })
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
    {
      "<leader>k",
      function()
        require("conjure.eval")["doc-word"]()
      end,
      desc = "Cojure hover doc",
    },
    {
      "<leader>lC",
      clojure_clean_restart_lsp,
      desc = "LSP Clean Restart",
    },
    {
      "<leader>lD",
      "<cmd>Trouble diagnostics focus=true<cr>",
      desc = "Workspace Diagnostics",
    },
    {
      "<leader>lI",
      "<cmd>LspInfo<cr>",
      desc = "Lsp Info",
    },
    {
      "<leader>lN",
      diag_prev,
      desc = "Prev Diagnostics",
    },
    {
      "<leader>lR",
      M.lsp_restart,
      desc = "Lsp Restart",
    },
    {
      "<leader>lS",
      "<cmd>FzfLua lsp_workspace_symbols<cr>",
      desc = "Workspace Symbols",
    },
    {
      "<leader>la",
      vim.lsp.buf.code_action,
      desc = "Code Actions",
    },
    { "<leader>lc", group = "Codelens" },
    {
      "<leader>lca",
      vim.lsp.codelens.run,
      desc = "Run Action",
    },
    {
      "<leader>lcc",
      function()
        vim.lsp.codelens.clear(nil, 0)
      end,
      desc = "Clear",
    },
    {
      "<leader>lcr",
      vim.lsp.codelens.refresh,
      desc = "Refresh",
    },
    {
      "<leader>ld",
      "<cmd>Trouble diagnostics filter.buf=0 focus=true<cr>",
      desc = "Document Diagnostics",
    },
    {
      "<leader>lx",
      function()
        vim.diagnostic.reset(nil, 0)
      end,
      desc = "Reset diagnostics",
    },
    { "<leader>le", "<cmd>e<cr>", desc = "Edit" },
    {
      "<leader>lh",
      function()
        if vim.lsp.inlay_hint then
          local filter = { bufnr = 0 }
          local flag = not vim.lsp.inlay_hint.is_enabled(filter)
          vim.lsp.inlay_hint.enable(flag, filter)
        end
      end,
      desc = "Inlay hints",
    },
    {
      "<leader>ll",
      diag_settings.toggle_virtual_line,
      desc = "Line Diagnostic",
    },
    {
      "<leader>ln",
      diag_next,
      desc = "Next Diagnostics",
    },
    {
      "<leader>lr",
      -- function()
      vim.lsp.buf.rename,
      -- vim.cmd("wa")
      -- end,
      desc = "Rename",
    },
    {
      "<leader>ls",
      "<cmd>FzfLua lsp_document_symbols<cr>",
      desc = "Document Symbols",
    },
    { "<leader>lw", group = "LSP Workspace" },
    {
      "<leader>lwa",
      vim.lsp.buf.add_workspace_folder,
      desc = "Workspace Add Folder",
    },
    {
      "<leader>lwr",
      vim.lsp.buf.remove_workspace_folder,
      desc = "Workspace Remove Folder",
    },
    { "K", vim.lsp.buf.hover, desc = "Hover doc" },
    {
      "gd",
      "<cmd>FzfLua lsp_definitions jump1=true<cr>",
      desc = "Go to Definition",
    },
    {
      "gi",
      "<cmd>FzfLua lsp_implementations jump1=true<cr>",
      desc = "Go to Impementations",
    },
    {
      "gr",
      "<cmd>FzfLua lsp_references<cr>",
      desc = "Symbol References",
    },
    {
      "gt",
      "<cmd>FzfLua lsp_typedefs jump1=true<cr>",
      desc = "Type Definitions",
    },
  }
end

return M
