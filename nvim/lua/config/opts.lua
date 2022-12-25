vim.o.hlsearch = true
vim.o.cursorline = true
vim.o.number = true
vim.o.mouse = 'a'
vim.o.breakindent = true
vim.o.undofile = true
vim.o.ignorecase = true
vim.o.smartcase = true
vim.o.signcolumn = 'yes'
vim.o.termguicolors = true
vim.o.completeopt = 'menuone,noselect'
vim.o.backup = false
vim.o.scrolloff = 5
vim.o.timeoutlen = 200
vim.o.updatetime = 200
vim.o.relativenumber = true
vim.o.wildmenu = true
vim.o.wildignore = '*/tmp/*,*.so,*.swp,*.zip'
vim.o.clipboard = 'unnamedplus'
vim.o.list = true
vim.o.listchars = 'tab:▶-,trail:•,extends:»,precedes:«'
vim.o.expandtab = true
vim.o.tabstop = 2
vim.o.shiftwidth = 2
vim.o.softtabstop = 2
vim.o.splitbelow = true
vim.o.splitright = true
vim.o.signcolumn = 'yes:1'
vim.o.colorcolumn = 80
vim.o.swapfile = false
vim.o.showmode = false
vim.o.cmdheight = 0

vim.g.mapleader = ' '
vim.g.maplocalleader = ','

local user_group = vim.api.nvim_create_augroup('UserGroup', { clear = true })
vim.api.nvim_create_autocmd('TextYankPost', {
  callback = function()
    vim.highlight.on_yank()
  end,
  group = user_group,
  pattern = '*',
})

vim.api.nvim_create_autocmd('FileType', {
  pattern = { 'help', 'man' },
  command = 'noremap <buffer> q <cmd>quit<cr>',
  group = user_group
})

local function set_terminal_keymaps()
  local opts = { buffer = 0 }
  local vks = vim.keymap.set
  vks('t', '<esc><esc>', '<C-\\><C-n>', opts)
  vks('t', '<C-h>', '<Cmd>wincmd h<CR>', opts)
  vks('t', '<C-j>', '<Cmd>wincmd j<CR>', opts)
  vks('t', '<C-k>', '<Cmd>wincmd k<CR>', opts)
  return vks('t', '<C-l>', '<Cmd>wincmd l<CR>', opts)
end

vim.api.nvim_create_autocmd('TermOpen', {
  pattern = 'term://*',
  callback = set_terminal_keymaps
})

