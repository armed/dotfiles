local M = {
  "natecraddock/workspaces.nvim",
  keys = {
    { "<leader>w" },
  },
  dependencies = {
    "nvim-neo-tree/neo-tree.nvim",
    "folke/which-key.nvim",
  },
}

-- Close conjure log buffers
local function close_repls()
  local bufnrs = vim.api.nvim_list_bufs()

  local mask = "conjure%-log*"
  for _, bufnr in pairs(bufnrs) do
    local name = vim.api.nvim_buf_get_name(bufnr)
    if string.match(name, mask) then
      vim.api.nvim_command("bdelete " .. bufnr)
    end
  end
end

M.session_file = ".nvim_session"

function M.config()
  local ntsm = require("neo-tree.sources.manager")
  local w = require("workspaces")
  local wk = require("which-key")

  local function session_exists()
    return vim.fn.filewritable(M.session_file) == 1
  end

  local function save_session()
    ntsm.close_all()
    close_repls()
    vim.cmd("mksession! " .. M.session_file)
  end

  local function load_workspace()
    if session_exists() then
      vim.cmd("so " .. M.session_file)
    end
  end

  local function add_workspace()
    save_session()
    w.add()
  end

  vim.api.nvim_create_autocmd("VimLeave", {
    callback = function()
      if session_exists() then
        save_session()
      end
    end,
  })

  w.setup({
    hooks = {
      open_pre = function()
        local utils = require("config.lsp.utils")
        vim.lsp.stop_client(utils.get_lsp_clients())
        if session_exists() then
          save_session()
          vim.cmd("sil %bwipeout!")
        end
      end,
    },
  })

  wk.add({
    { "<leader>w", group = "Workspaces" },
    { "<leader>wa", add_workspace, desc = "Add" },
    { "<leader>wf", ":Telescope workspaces<cr>", desc = "List" },
    { "<leader>wl", load_workspace, desc = "Load existing" },
    { "<leader>wr", w.remove, desc = "Remove" },
  })
end

return M
