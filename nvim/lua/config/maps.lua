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

