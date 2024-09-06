local M = {
  "nvim-neo-tree/neo-tree.nvim",
  cmd = "Neotree",
  keys = {
    { "<leader>e", desc = "NeoTree" },
  },
  branch = "v3.x",
  dependencies = {
    "kyazdani42/nvim-web-devicons",
    "nvim-lua/plenary.nvim",
    "MunifTanjim/nui.nvim",
    {
      "s1n7ax/nvim-window-picker",
      tag = "v1.5",
    },
  },
}

local function get_palette()
  local theme = vim.g.colors_name

  if theme == "kanagawa" then
    local kw = require("kanagawa.colors")
    local kw_colors = kw.setup()
    return {
      win_hl = kw_colors.palette.crystalBlue,
      fg = kw_colors.palette.sumiInk0,
    }
  elseif theme == "catppuccin" then
    local cp = require("catppuccin.palettes")
    local cp_colors = cp.get_palette("mocha")
    return {
      win_hl = cp_colors.blue,
      fg = cp_colors.crust,
    }
  end
  -- fallback
  return {
    win_hl = "#000",
    fg = "#999",
  }
end

function M.config()
  local wp = require("window-picker")
  local wk = require("which-key")
  local palette = get_palette()
  local nt = require("neo-tree")

  wk.add({
    { "<leader>e", group = "Neotree" },
    { "<leader>eb", "<cmd>Neotree buffers show<cr>", desc = "Show buffers" },
    {
      "<leader>eg",
      "<cmd>Neotree git_status show<cr>",
      desc = "Show git status",
    },
    { "<leader>er", "<cmd>Neotree reveal show<cr>", desc = "Reveal file" },
    { "<leader>ee", "<cmd>Neotree focus<cr>", desc = "Show and focus" },
    { "<leader>ef", "<cmd>Neotree show<cr>", desc = "Show" },
    { "<leader>eq", "<cmd>Neotree close<cr>", desc = "Close" },
  })

  wp.setup({
    autoselect_one = true,
    other_win_hl_color = palette.win_hl,
    fg_color = palette.fg,
    show_prompt = true,
    filter_rules = {
      bo = {
        filetype = { "neo-tree", "neo-tree-popup", "notify", "alpha" },
        buftype = { "terminal", "quickfix" },
      },
      file_name_contains = { "conjure-log-*" },
    },
    include_current_win = false,
  })

  nt.setup({
    use_popups_for_input = false,
    sources = {
      "filesystem",
      "buffers",
      "git_status",
      "document_symbols",
    },
    window = {
      mappings = {
        ["<tab>"] = "toggle_node",
        ["<space>"] = false,
      },
    },
    source_selector = {
      sources = {
        { source = "filesystem" },
        { source = "document_symbols" },
      },
    },
    filesystem = {
      use_libuv_file_watcher = true,
      hide_gitignored = true,
      cwd_target = { sidebar = "tab", current = "tab" },
      follow_current_file = { enabled = true },
      group_empty_dirs = false,
    },
  })
end

return M
