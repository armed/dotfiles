local M = {
  "nvim-neo-tree/neo-tree.nvim",
  cmd = "Neotree",
  branch = "v3.x",
  dependencies = {
    "kyazdani42/nvim-web-devicons",
    "s1n7ax/nvim-window-picker",
    "nvim-lua/plenary.nvim",
    "MunifTanjim/nui.nvim",
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
  local palette = get_palette()
  local nt = require("neo-tree")

  wp.setup({
    autoselect_one = true,
    other_win_hl_color = palette.win_hl,
    fg_color = palette.fg,
    filter_rules = {
      bo = {
        filetype = { "neo-tree", "neo-tree-popup", "notify", "alpha" },
        buftype = { "terminal", "quickfix" },
      },
      file_name_contains = { "conjure-log-*" },
    },
    include_current = false,
  })

  nt.setup({
    use_popups_for_input = false,
    window = {
      mappings = {
        ["<tab>"] = "toggle_node",
        ["<space>"] = false,
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
