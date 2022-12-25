local M = {
  'goolord/alpha-nvim',
  lazy = false
}

function M.config()
  local alpha = require('alpha')
  local dashboard = require('alpha.themes.dashboard')

  dashboard.section.header.val = {
    '                                                     ',
    '                                                     ',
    '                                                     ',
    '                                                     ',
    '                                                     ',
    '                                                     ',
    '  ███╗   ██╗███████╗ ██████╗ ██╗   ██╗██╗███╗   ███╗ ',
    '  ████╗  ██║██╔════╝██╔═══██╗██║   ██║██║████╗ ████║ ',
    '  ██╔██╗ ██║█████╗  ██║   ██║██║   ██║██║██╔████╔██║ ',
    '  ██║╚██╗██║██╔══╝  ██║   ██║╚██╗ ██╔╝██║██║╚██╔╝██║ ',
    '  ██║ ╚████║███████╗╚██████╔╝ ╚████╔╝ ██║██║ ╚═╝ ██║ ',
    '  ╚═╝  ╚═══╝╚══════╝ ╚═════╝   ╚═══╝  ╚═╝╚═╝     ╚═╝ ',
    '                                                     '
  }

  dashboard.section.buttons.val = {
    dashboard.button('SPC f f', '  > Find file', ':Telescope find_files<CR>'),
    dashboard.button('SPC f r', '  > Recent', ':Telescope oldfiles<CR>'),
    dashboard.button('SPC S f', '  > Workspaces', ':Telescope workspaces<CR>'),
    dashboard.button('q', '  > Quit NVIM', ':qa<CR>')
  }

  alpha.setup(dashboard.opts)

  vim.cmd('autocmd FileType alpha setlocal nofoldenable')
  -- vim.cmd('Alpha')
end

return M

