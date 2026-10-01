local diag_settings = require("config.lsp.diagnostics")
local NuiMenu = require("nui.menu")
local NuiText = require("nui.text")
local NuiLine = require("nui.line")
local event = require("nui.utils.autocmd").event

local function diag_next()
  vim.diagnostic.jump({ count = vim.v.count1 })
end

local function diag_prev()
  vim.diagnostic.jump({ count = -vim.v.count1 })
end

local M = {}

local function restart_client(client)
  local name = client.name
  local bufnr = vim.api.nvim_get_current_buf()
  client:stop()
  -- vim.lsp.stop_client(client.id)
  vim.defer_fn(function()
    if name == "jdtls" then
      require("config.lsp.custom.jdtls").start(bufnr)
    else
      vim.lsp.enable(name)
    end
  end, 500)
  vim.notify("Restarting " .. name, vim.log.levels.INFO)
end

function M.lsp_restart()
  local clients = vim.lsp.get_clients({ bufnr = 0 })

  if #clients == 0 then
    vim.notify("No LSP clients attached", vim.log.levels.WARN)
    return
  end

  if #clients == 1 then
    restart_client(clients[1])
    return
  end

  local menu_items = {
    NuiMenu.item(NuiLine({ NuiText("All", "Special") }), { id = "all" }),
    NuiMenu.separator("─"),
  }

  for _, client in ipairs(clients) do
    table.insert(menu_items, NuiMenu.item(client.name, { id = client.id }))
  end

  local menu = NuiMenu({
    position = "50%",
    size = { width = 40, height = #clients + 4 },
    relative = "editor",
    border = {
      style = "rounded",
      text = {
        top = NuiLine({ NuiText(" LSP Restart ", "WarningMsg") }),
        top_align = "center",
      },
    },
    win_options = {
      winhighlight = "Normal:Normal,FloatBorder:Normal",
    },
  }, {
    lines = menu_items,
    keymap = {
      focus_next = { "j", "<Down>", "<Tab>" },
      focus_prev = { "k", "<Up>", "<S-Tab>" },
      close = { "<Esc>", "<C-c>", "q" },
      submit = { "<CR>" },
    },
    on_submit = function(item)
      if item.id == "all" then
        for _, client in ipairs(clients) do
          restart_client(client)
        end
      else
        for _, client in ipairs(clients) do
          if client.id == item.id then
            restart_client(client)
            break
          end
        end
      end
    end,
  })

  menu:mount()
  menu:on(event.BufLeave, function()
    menu:unmount()
  end)
end

local function clojure_clean_restart_lsp()
  local ft = vim.bo.filetype
  if ft == "clojure" then
    local clients = vim.lsp.get_clients({ bufnr = 0, name = "clojure_lsp" })
    if #clients > 0 then
      vim.fn.delete(clients[1].root_dir .. "/.lsp/.cache", "rf")
      restart_client(clients[1])
    end
  end
end

function M.setup()
  return {
    {
      "<leader>k",
      function()
        if vim.bo.filetype == "clojure" then
          require("conjure.eval")["doc-word"]()
        else
          vim.lsp.buf.hover()
        end
      end,
      desc = "Conjure hover doc",
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
      "<cmd>silent checkhealth vim.lsp<cr>",
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
      function()
        diag_settings.toggle_virtual_line(false)
      end,
      desc = "Buffer Line Diagnostic",
    },
    {
      "<leader>lL",
      function()
        diag_settings.toggle_virtual_line(true)
      end,
      desc = "Cursor Line Diagnostic",
    },
    {
      "<leader>ln",
      diag_next,
      desc = "Next Diagnostics",
    },
    {
      "<leader>lr",
      vim.lsp.buf.rename,
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
