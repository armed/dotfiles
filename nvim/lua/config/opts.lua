vim.o.hlsearch = true
vim.o.wrap = false
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
vim.o.colorcolumn = '80'
vim.o.swapfile = false
vim.o.showmode = false
vim.o.cmdheight = 0
vim.o.hidden = true
vim.o.ssop = 'sesdir,winsize,buffers,tabpages'

vim.g.mapleader = ' '
vim.g.maplocalleader = ','

local builtins = {
  "getscript",
  "getscriptPlugin",
  "vimball",
  "vimballPlugin",
  "2html_plugin",
  "matchit",
  "logiPat",
  "rrhelper",
  "netrw",
  "netrwPlugin",
  "netrwSettings",
  "netrwFileHandlers",
}

for _, plugin in ipairs(builtins) do
  vim.g["loaded_" .. plugin] = 1
end
