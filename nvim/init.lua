require('config.opts')
require('config.lazy')

vim.api.nvim_create_autocmd('User', {
  pattern = 'VeryLazy',
  callback = function()
    require('config.maps')
  end
})

