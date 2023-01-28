local M = {
  'folke/which-key.nvim',
  event = 'VeryLazy',
  dependencies = {
    'ThePrimeagen/harpoon'
  }
}

function M.config()
  local wk = require('which-key')
  local hm = require 'harpoon.mark'
  local hui = require 'harpoon.ui'

  wk.setup {
    window = { border = 'double' },
    layout = { align = 'center' },
    hidden = {
      "<silent>", "<cmd>", "<Cmd>", "<CR>", "call",
      "lua", "^:", "^ ", "<Plug>", '^%(', '%)$'
    }
  }

  local function save_all_quit()
    vim.cmd('wa')
    vim.cmd('qa!')
  end

  wk.register({
    o = {
      ':Oil .<cr>',
      'Oil Dir Editor'
    },
    b = {
      name = 'Harpoon',
      a = { hm.add_file, 'Mark File' },
      b = { hui.toggle_quick_menu, 'Menu' },
      l = { hui.nav_next, 'Next File' },
      h = { hui.nav_prev, 'Prev File' }
    },
    h = {
      name = 'Gitsigns',
      b = { ':Gitsigns blame_line<cr>', 'Blame line' },
      p = { ':Gitsigns preview_hunk<cr>', 'Preview hunk' },
      s = { ':Gitsigns stage_hunk<cr>', 'Stage hunk' },
      u = { ':Gitsigns undo_stage_hunk<cr>', 'Undo stage hunk' },
      r = { ':Gitsigns reset_hunk<CR>', 'Reset hunk' },
      S = { ':Gitsigns stage_buffer<cr>', 'Stage buffer' },
      R = { ':Gitsigns reset_buffer<cr>', 'Reset buffer' },
      n = { ':Gitsigns next_hunk<cr>', 'Next hunk' },
      N = { ':Gitsigns prev_hunk<cr>', 'Prev hunk' },
      t = {
        name = 'Toggle',
        b = { ':Gitsigns toggle_current_line_blame<cr>', 'Curent line blame' },
        d = { ':Gitsigns toggle_deleted<cr>', 'Deleted' }
      },
      d = { ':Gitsigns diffthist<cr>', 'Diff history' },
      D = { ':Gitsigns diffhis ~<cr>', 'Diff ~history' }
    },
    U = { ':UndotreeToggle<cr>', 'Undo Tree' },
    t = {
      name = 'Terminal',
      v = { ':vsplit | term<cr>', 'Vert Split Termial' },
      s = { ':split | term<cr>', 'Split Terminal' }
    },
    g = {
      name = 'Git',
      g = { ':Neogit<cr>', 'Status' },
      p = { ':Git push<cr>', 'Push' },
      P = { ':Git push --force<cr>', 'Force Push' },
      f = { ':Git pull<cr>', 'Pull' },
      b = { ':Telescope git_branches<cr>', 'Branches' }
    },
    e = { ':Neotree toggle<cr>', 'Toggle Neo Tree' },
    E = { ':Neotree focus<cr>', 'Focus Neo Tree' },
    s = { ':write<cr>', 'Save buffer' },
    S = { 'wa<ce>', 'Save all'},
    x = { save_all_quit, 'Save and quit' },
    q = { '<c-w>q', 'Close window' },
    r = { ':Telescope resume<cr>', 'Resume last search' },
    f = {
      name = 'Find',
      f = { ':Telescope find_files<cr>', 'Files' },
      c = { ':Telescope current_buffer_fuzzy_find<cr>', 'In buffer' },
      g = { ':Telescope live_grep<cr>', 'Live grep' },
      b = { ':Telescope buffers<cr>', 'Buffers' },
      r = { ':Telescope oldfiles cwd_only=true<cr>', 'Recent files' }
    },
    L = { ':Lazy<cr>', 'Lazy' }
  }, { prefix = '<leader>' })
end

return M
