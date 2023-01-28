local user_group = vim.api.nvim_create_augroup('UserGroup', { clear = true })

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

-- This file is automatically loaded by plugins.init

-- Check if we need to reload the file when it changed
vim.api.nvim_create_autocmd(
  { "FocusGained", "TermClose", "TermLeave" },
  { command = "checktime" }
)

-- Highlight on yank
vim.api.nvim_create_autocmd("TextYankPost", {
  callback = function()
    vim.highlight.on_yank()
  end,
})

-- resize splits if window got resized
vim.api.nvim_create_autocmd({ "VimResized" }, {
  callback = function()
    vim.cmd("tabdo wincmd =")
  end,
})

-- go to last loc when opening a buffer
vim.api.nvim_create_autocmd("BufReadPost", {
  callback = function()
    local mark = vim.api.nvim_buf_get_mark(0, '"')
    local lcount = vim.api.nvim_buf_line_count(0)
    if mark[1] > 0 and mark[1] <= lcount then
      pcall(vim.api.nvim_win_set_cursor, 0, mark)
    end
  end,
})

-- close some filetypes with <q>
vim.api.nvim_create_autocmd("FileType", {
  pattern = {
    "qf",
    "help",
    "man",
    "notify",
    "lspinfo",
    "spectre_panel",
    "startuptime",
    "tsplayground",
    "PlenaryTestPopup",
  },
  callback = function(event)
    vim.bo[event.buf].buflisted = false
    vim.keymap.set("n", "q", "<cmd>close<cr>", { buffer = event.buf, silent = true })
  end,
})

vim.api.nvim_create_autocmd("FileType", {
  pattern = { "gitcommit", "markdown" },
  callback = function()
    vim.opt_local.wrap = true
    vim.opt_local.spell = true
  end,
})
