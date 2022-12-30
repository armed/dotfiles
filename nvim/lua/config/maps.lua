local map = function(mode, keys, func, opts)
  local opts_ = opts or {}
  opts_.noremap = true
  vim.keymap.set(mode, keys, func, opts_)
end

local nmap = function(keys, func, opts)
  map('n', keys, func, opts)
end

local imap = function(keys, func, opts)
  map('i', keys, func, opts)
end
-- basic
nmap('<esc>', ':noh<cr>', { silent = true })
imap('jj', '<esc>')
imap('jk', '<esc>')
imap('kj', '<esc>')
imap('kk', '<esc>')

-- windows/tabs
nmap('<C-w>T', ':tab split<cr>', { silent = true })
nmap('<C-h>', '<C-w>h', { desc = 'Move to left window' })
nmap('<C-l>', '<C-w>l', { desc = 'Move to right window' })
nmap('<C-j>', '<C-w>j', { desc = 'Move to window below' })
nmap('<C-k>', '<C-w>k', { desc = 'Move to window above' })
-- window resize
nmap('<A-Up>', '<cmd>resize -2<CR>')
nmap('<A-Down>', '<cmd>resize +2<CR>')
nmap('<A-Right>', '<cmd>vertical resize -2<CR>')
nmap('<A-Left>', '<cmd>vertical resize +2<CR>')
-- nop for space
map({ 'n', 'v' }, '<Space>', '<Nop>', { silent = true })

local function save_all_quit()
  vim.cmd('wa')
  vim.cmd('quitall!')
end

local hm = require 'harpoon.mark'
local hui = require 'harpoon.ui'

require('which-key').register({
  b = {
    name = 'Harpoon',
    a = { hm.add_file, 'Mark File' },
    b = { hui.toggle_quick_menu, 'Menu' },
    l = { hui.nav_next, 'Next File' },
    h = { hui.nav_prev, 'Prev File' }
  },
  h = {
    name = "Gitsigns",
    b = { ':Gitsigns blame_line<cr>', "Blame line" },
    p = { ':Gitsigns preview_hunk<cr>', "Preview hunk" },
    s = { ":Gitsigns stage_hunk<cr>", "Stage hunk" },
    u = { ':Gitsigns undo_stage_hunk<cr>', "Undo stage hunk" },
    r = { ":Gitsigns reset_hunk<CR>", "Reset hunk" },
    S = { ':Gitsigns stage_buffer<cr>', "Stage buffer" },
    R = { ':Gitsigns reset_buffer<cr>', "Reset buffer" },
    t = {
      name = "Toggle",
      b = { ':Gitsigns toggle_current_line_blame<cr>', "Curent line blame" },
      d = { ':Gitsigns toggle_deleted<cr>', "Deleted" }
    },
    d = { ':Gitsigns diffthist<cr>', "Diff history" },
    D = { ':Gitsigns diffhis ~<cr>', "Diff ~history" }
  },
  u = { ':UndotreeToggle<cr>', 'Undo Tree' },
  t = {
    name = 'Terminal',
    v = { ':vsplit | term<cr>', 'Vert Split Termial' },
    s = { ':split | term<cr>', 'Split Terminal' }
  },
  g = {
    name = 'Git',
    l = { ':Git log<cr>', 'Log' },
    s = { ':Git<cr><C-w>L', 'Status' },
    p = { ':Git push<cr>', 'Push' },
    P = { ':Git push --force<cr>', 'Force Push' },
    f = { ':Git pull<cr>', 'Pull' },
    b = { ':Telescope git_branches<cr>', 'Branches' }
  },
  e = { ":Neotree toggle<cr>", "Toggle Neo Tree" },
  E = { ":Neotree focus<cr>", "Focus Neo Tree" },
  s = { ':write<cr>', 'Save buffer' },
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
