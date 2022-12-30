require('config.opts')
require('config.aucommands')
require('config.hl-groups')
require('config.lazy')

vim.api.nvim_create_autocmd('User', {
  pattern = 'VeryLazy',
  callback = function()
    require('config.maps')
  end
})

