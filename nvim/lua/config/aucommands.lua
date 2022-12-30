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

