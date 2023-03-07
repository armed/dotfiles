local opt = vim.opt

opt.hlsearch = true
opt.wrap = false
opt.cursorline = true
opt.number = true
opt.mouse = "a"
opt.breakindent = true
opt.undofile = true
opt.ignorecase = true
opt.smartcase = true
opt.signcolumn = "yes"
opt.termguicolors = true
opt.completeopt = "menuone,noselect"
opt.backup = false
opt.scrolloff = 5
opt.timeoutlen = 200
opt.updatetime = 200
opt.relativenumber = true
opt.wildmenu = true
opt.wildignore = "*/tmp/*,*.so,*.swp,*.zip"
opt.clipboard = "unnamedplus"
opt.list = true
-- opt.listchars = "tab:▶-,trail:•,extends:»,precedes:«"
opt.expandtab = true
opt.smartindent = true
opt.tabstop = 2
opt.shiftwidth = 2
opt.softtabstop = 2
opt.splitbelow = true
opt.splitright = true
opt.signcolumn = "yes:1"
opt.colorcolumn = "80"
opt.swapfile = false
opt.showmode = false
opt.cmdheight = 0
opt.hidden = true
opt.ssop = "sesdir,winsize,buffers,tabpages"
opt.wildmode = "longest:full,full" -- Command-line completion mode
opt.spelllang = { "en" }
opt.grepprg = "rg --vimgrep"
opt.laststatus = 0
opt.pumblend = 10 -- Popup blend
opt.pumheight = 10 -- Maximum number of entries in a popup

vim.g.mapleader = " "
vim.g.maplocalleader = ","
vim.g.markdown_recommended_style = 0

if vim.fn.has("nvim-0.9.0") == 1 then
  opt.splitkeep = "screen"
  opt.shortmess:append({ C = true })
end

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
