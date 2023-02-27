local function map(mode, lhs, rhs, opts)
  ---@diagnostic disable-next-line: undefined-field
  local keys = require("lazy.core.handler").handlers.keys
  ---@cast keys LazyKeysHandler
  -- do not create the keymap if a lazy keys handler exists
  if not keys.active[keys.parse({ lhs, mode = mode }).id] then
    vim.keymap.set(mode, lhs, rhs, opts)
  end
end

-- escape insert
map("i", "jj", "<esc>", { silent = true })
map("i", "jk", "<esc>", { silent = true })
map("i", "kj", "<esc>", { silent = true })
map("i", "kk", "<esc>", { silent = true })

-- better up/down
map("n", "j", "v:count == 0 ? 'gj' : 'j'", { expr = true, silent = true })
map("n", "k", "v:count == 0 ? 'gk' : 'k'", { expr = true, silent = true })

-- Move using tmux.nvim
map("n", "<C-h>", [[<cmd>lua require("tmux").move_left()<cr>]], { desc = "Go to left window" })
map("n", "<C-j>", [[<cmd>lua require("tmux").move_bottom()<cr>]], { desc = "Go to lower window" })
map("n", "<C-k>", [[<cmd>lua require("tmux").move_top()<cr>]], { desc = "go to upper window" })
map("n", "<C-l>", [[<cmd>lua require("tmux").move_right()<cr>]], { desc = "Go to right window" })

-- Resize window using tmux.nvim
map("n", "<A-Up>", [[<cmd>lua require("tmux").resize_top()<cr>]], { desc = "Increase window height" })
map("n", "<A-Down>", [[<cmd>lua require("tmux").resize_bottom()<cr>]], { desc = "Decrease window height" })
map("n", "<A-Left>", [[<cmd>lua require("tmux").resize_left()<cr>]], { desc = "Decrease window width" })
map("n", "<A-Right>", [[<cmd>lua require("tmux").resize_right()<cr>]], { desc = "Increase window width" })

-- Move Lines
map("n", "<A-j>", ":m .+1<cr>==", { desc = "Move down" })
map("v", "<A-j>", ":m '>+1<cr>gv=gv", { desc = "Move down" })
map("i", "<A-j>", "<Esc>:m .+1<cr>==gi", { desc = "Move down" })
map("n", "<A-k>", ":m .-2<cr>==", { desc = "Move up" })
map("v", "<A-k>", ":m '<-2<cr>gv=gv", { desc = "Move up" })
map("i", "<A-k>", "<Esc>:m .-2<cr>==gi", { desc = "Move up" })

-- buffers
map("n", "<S-h>", "<cmd>bprevious<cr>", { desc = "Prev buffer" })
map("n", "<S-l>", "<cmd>bnext<cr>", { desc = "Next buffer" })
map("n", "[b", "<cmd>bprevious<cr>", { desc = "Prev buffer" })
map("n", "]b", "<cmd>bnext<cr>", { desc = "Next buffer" })

-- Clear search with <esc>
map({ "i", "n" }, "<esc>", "<cmd>noh<cr><esc>", { desc = "Escape and clear hlsearch" })

-- https://github.com/mhinz/vim-galore#saner-behavior-of-n-and-n
map("n", "n", "'Nn'[v:searchforward]", { expr = true, desc = "Next search result" })
map("x", "n", "'Nn'[v:searchforward]", { expr = true, desc = "Next search result" })
map("o", "n", "'Nn'[v:searchforward]", { expr = true, desc = "Next search result" })
map("n", "N", "'nN'[v:searchforward]", { expr = true, desc = "Prev search result" })
map("x", "N", "'nN'[v:searchforward]", { expr = true, desc = "Prev search result" })
map("o", "N", "'nN'[v:searchforward]", { expr = true, desc = "Prev search result" })

-- Add undo break-points
map("i", ",", ",<c-g>u")
map("i", ".", ".<c-g>u")
map("i", ";", ";<c-g>u")

local Util = require("lazy.core.util")
local function toggle(option, silent, values)
  if values then
    if vim.opt_local[option]:get() == values[1] then
      vim.opt_local[option] = values[2]
    else
      vim.opt_local[option] = values[1]
    end
    return Util.info("Set " .. option .. " to " .. vim.opt_local[option]:get(), { title = "Option" })
  end
  vim.opt_local[option] = not vim.opt_local[option]:get()
  if not silent then
    if vim.opt_local[option]:get() then
      Util.info("Enabled " .. option, { title = "Option" })
    else
      Util.warn("Disabled " .. option, { title = "Option" })
    end
  end
end

-- toggle options
map("n", "<leader>us", function()
  toggle("spell")
end, { desc = "Toggle Spelling" })
map("n", "<leader>uw", function()
  toggle("wrap")
end, { desc = "Toggle Word Wrap" })
map("n", "<leader>ur", function()
  toggle("relativenumber")
end, { desc = "Toggle Relative Line Numbers" })
map("n", "<leader>ul", function()
  toggle("relativenumber", true)
  toggle("number")
end, { desc = "Toggle Line Numbers" })

local conceallevel = vim.o.conceallevel > 0 and vim.o.conceallevel or 3
map("n", "<leader>uc", function()
  toggle("conceallevel", false, { 0, conceallevel })
end, { desc = "Toggle Conceal" })

-- tabs
map("n", "<leader><tab>l", "<cmd>tablast<cr>", { desc = "Last Tab" })
map("n", "<leader><tab>f", "<cmd>tabfirst<cr>", { desc = "First Tab" })
map("n", "<leader><tab><tab>", "<cmd>tabnew<cr>", { desc = "New Tab" })
map("n", "<leader><tab>]", "<cmd>tabnext<cr>", { desc = "Next Tab" })
map("n", "<leader><tab>d", "<cmd>tabclose<cr>", { desc = "Close Tab" })
map("n", "<leader><tab>[", "<cmd>tabprevious<cr>", { desc = "Previous Tab" })

-- local remap = vim.api.nvim_set_keymap
-- remap("n", "<TAB>", ">>", { noremap = true })
-- remap("n", "<S-TAB>", "<<", { noremap = true })
-- remap("v", "<TAB>", ">gv", { noremap = true })
-- remap("v", "<S-TAB>", "<gv", { noremap = true })
