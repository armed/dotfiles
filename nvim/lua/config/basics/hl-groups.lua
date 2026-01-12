vim.api.nvim_command("hi link IlluminatedWordRead LspReferenceRead")
vim.api.nvim_command("hi link IlluminatedWordWrite LspReferenceWrite")
vim.api.nvim_command("hi link IlluminatedWordText LspReferenceRead")

vim.api.nvim_command("hi user.repl.winbar guibg=#ffaa88 guifg=black cterm=bold")
vim.api.nvim_command(
  "hi user.repl.statusline guifg=#ffaa88 guibg=none cterm=bold"
)

-- default one
vim.api.nvim_command("hi user.win.title guifg=black guibg=grey")

vim.api.nvim_set_hl(0, "Green", { fg = "#98bb6c", bold = true })
