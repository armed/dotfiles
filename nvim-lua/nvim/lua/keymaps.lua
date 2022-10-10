local key = vim.api.nvim_set_keymap

key("n", "<esc>", ":noh<cr>", {noremap = true})
key("i", "jj", "<esc>", {noremap = true})
key("i", "kj", "<esc>", {noremap = true})
key("i", "jk", "<esc>", {noremap = true})
key("i", "kk", "<esc>", {noremap = true})

-- escape from terminal normal mode
key("t", "<esc><esc>", "<c-\\><c-n>", {noremap = true})

key("n", "<C-h>", "<C-w>h", {noremap = true})
key("n", "<C-j>", "<C-w>j", {noremap = true})
key("n", "<C-k>", "<C-w>k", {noremap = true})
key("n", "<C-l>", "<C-w>l", {noremap = true})

key("n", "<A-Up>", "<cmd>resize -2<CR>", {noremap = true})
key("n", "<A-Down>", "<cmd>resize +2<CR>", {noremap = true})
key("n", "<A-Right>", "<cmd>vertical resize -2<CR>", {noremap = true})
key("n", "<A-Left>", "<cmd>vertical resize +2<CR>", {noremap = true})

local packer = require("packer")
require("which-key").register({
  p = {
    name = "Packer",
    i = {packer.install, "Install"},
    c = {packer.clean, "Clean"},
    s = {packer.sync, "Sync"},
    C = {packer.compile, "Compile"},
    S = {packer.status, "Status"}
  },
  x = {"<cmd>xa<cr>", "Save and exit"},
  q = {"<c-w>q", "Close window"}
},
{ prefix = "<leader>" })

