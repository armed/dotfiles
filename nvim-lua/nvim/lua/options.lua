vim.g.mapleader = " "
vim.g.maplocalleader = ","

local opts = {
  termguicolors = true,
  cursorline = true,
  winfixheight = true,
  equalalways = true,
  encoding = "utf-8",
  scrolloff = 5,
  backspace = "2",
  colorcolumn = "80",
  errorbells = true,
  updatetime = 200,
  timeoutlen = 200,
  number = true,
  relativenumber = true,
  ruler = true,
  completeopt = "menuone,noselect",
  wildmenu = true,
  wildignore = "*/tmp/*,*.so,*.swp,*.zip",
  ignorecase = true,
  smartcase = true,
  clipboard = "unnamedplus",
  list = true,
  listchars = "tab:▶-,trail:•,extends:»,precedes:«",
  expandtab = true,
  tabstop = 2,
  shiftwidth = 2,
  softtabstop = 2,
  undofile = true,
  splitbelow = true,
  splitright = true,
  hlsearch = true,
  signcolumn = "auto",
  winfixwidth = false,
  backup = false,
  swapfile = false,
  showmode = false
}

for o, v in pairs(opts) do
  vim.o[o] = v
end

