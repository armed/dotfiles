local M = {
  'nvim-neo-tree/neo-tree.nvim',
  cmd = 'Neotree',
  branch       = 'v2.x',
  dependencies = {
    'kyazdani42/nvim-web-devicons',
    's1n7ax/nvim-window-picker',
    'nvim-lua/plenary.nvim',
    'MunifTanjim/nui.nvim'
  }
}

function M.config()
  local wp = require('window-picker')
  local cp = require('catppuccin.palettes')
  local nt = require('neo-tree')

  local palette = cp.get_palette 'mocha'

  nt.setup {
    window = {
      mappings = {
        ["<tab>"] = "toggle_node",
        ["<space>"] = false
      }
    },
    filesystem = {
      use_libuv_file_watcher = true,
      hide_gitignored = true,
      cwd_target = { sidebar = "tab", current = "tab" },
      follow_current_file = true,
      group_empty_dirs = true
    }
  }

  wp.setup {
    autoselect_one = true,
    other_win_hl_color = palette.blue,
    fg_color = palette.crust,
    filter_rules = {
      bo = {
        filetype = { "neo-tree", "neo-tree-popup", "notify" },
        buftype = { "terminal", "quickfix" }
      },
      file_name_contains = { "conjure-log-*" }
    },
    include_current = false
  }
end

return M
