local function init()
  vim.api.nvim_command("hi link IlluminatedWordRead LspReferenceRead")
  vim.api.nvim_command("hi link IlluminatedWordWrite LspReferenceWrite")
  vim.api.nvim_command("hi link IlluminatedWordText LspReferenceRead")
  -- NOTE: workaround after treesitter update (wait for kanagawa update I guess)
  vim.api.nvim_command("hi DoNothing guifg=NONE guibg=NONE gui=NONE cterm=NONE")
  vim.api.nvim_command("hi link @field.clojure DoNothing")

  vim.api.nvim_command(
    "hi user.repl.winbar guibg=#ffaa88 guifg=black cterm=bold"
  )
  vim.api.nvim_command(
    "hi user.repl.statusline guifg=#ffaa88 guibg=none cterm=bold"
  )
end

-- default one
vim.api.nvim_command("hi user.win.title guifg=black guibg=grey")

init()

return { init = init }
