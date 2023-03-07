local autocmd = vim.api.nvim_create_autocmd
local augroup = vim.api.nvim_create_augroup

-- General Settings
local general = augroup("General Settings", { clear = true })

autocmd("VimEnter", {
  callback = function(data)
    -- buffer is a directory
    local directory = vim.fn.isdirectory(data.file) == 1

    -- change to the directory
    if directory then
      vim.cmd.cd(data.file)
      -- open the tree
      vim.cmd("Neotree")
    end
  end,
  group = general,
  desc = "Open NvimTree when it's a Directory",
})

-- autocmd("BufModifiedSet", {
--   callback = function()
--     vim.cmd("silent! w")
--   end,
--   group = general,
--   desc = "Auto Save",
-- })

-- autocmd("TermOpen", {
--   callback = function(evt)
--     vim.opt_local.relativenumber = false
--     vim.opt_local.number = false
--     print(vim.inspect(evt))
--     local opts = { buffer = 0 }
--     local map = vim.keymap.set
--     map("t", "<esc><esc>", "<C-\\><C-n>", opts)
--     map("t", "<C-h>", "<Cmd>wincmd h<CR>", opts)
--     map("t", "<C-j>", "<Cmd>wincmd j<CR>", opts)
--     map("t", "<C-k>", "<Cmd>wincmd k<CR>", opts)
--     map("t", "<C-l>", "<Cmd>wincmd l<CR>", opts)
--     vim.cmd("startinsert!")
--   end,
--   pattern = "term://*",
--   group = general,
--   desc = "Terminal Options",
-- })

-- Check if we need to reload the file when it changed
autocmd({ "FocusGained", "TermClose", "TermLeave" }, { command = "checktime" })

-- Highlight on yank
autocmd("TextYankPost", {
  group = general,
  callback = function()
    vim.highlight.on_yank()
  end,
  desc = "Highlight on Yank",
})

-- resize splits if window got resized
autocmd({ "VimResized" }, {
  group = general,
  callback = function()
    vim.cmd("tabdo wincmd =")
  end,
  desc = "Equalize windows on resize",
})

-- go to last loc when opening a buffer
autocmd("BufReadPost", {
  group = general,
  callback = function()
    local mark = vim.api.nvim_buf_get_mark(0, '"')
    local lcount = vim.api.nvim_buf_line_count(0)
    if mark[1] > 0 and mark[1] <= lcount then
      pcall(vim.api.nvim_win_set_cursor, 0, mark)
    end
  end,
})

-- close some filetypes with <q>
autocmd("FileType", {
  group = general,
  pattern = {
    "qf",
    "help",
    "man",
    "notify",
    "lspinfo",
    "spectre_panel",
    "startuptime",
    "tsplayground",
    "nvim-docs-view",
    "PlenaryTestPopup",
  },
  callback = function(event)
    vim.bo[event.buf].buflisted = false
    vim.keymap.set("n", "q", "<cmd>close<cr>", { buffer = event.buf, silent = true })
  end,
  desc = "Close by q",
})

autocmd("FileType", {
  group = general,
  pattern = { "gitcommit", "markdown" },
  callback = function()
    vim.opt_local.wrap = true
    vim.opt_local.spell = true
  end,
})

autocmd("FileType", {
  group = general,
  pattern = { "nvim-docs-view" },
  callback = function()
    vim.opt_local.conceallevel = 3
  end,
})

autocmd("ColorScheme", {
  group = general,
  pattern = "*",
  callback = function()
    -- some themes cleans hl groups, we are overriding them here
    require("config.hl-groups").init()
  end,
})
