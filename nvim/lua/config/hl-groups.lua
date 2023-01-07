local api = vim.api

-- used in incline, should be overridden in theme config
api.nvim_command('hi user.win.title guifg=black guibg=grey')
api.nvim_command('hi user.repl.winbar guibg=#ffaa88 guifg=black cterm=bold')
api.nvim_command('hi user.repl.statusline guifg=#ffaa88 guibg=none cterm=bold')

