local lazypath = vim.fn.stdpath('data') .. '/lazy/lazy.nvim'
if not vim.loop.fs_stat(lazypath) then
  vim.fn.system({
    'git',
    'clone',
    '--filter=blob:none',
    '--single-branch',
    'git@github.com:folke/lazy.nvim.git',
    lazypath,
  })
end
vim.opt.runtimepath:prepend(lazypath)

-- load lazy
-- loads everything with name `config.plugins` 
-- and everything in directory `config.plugins`
require('lazy').setup('config.plugins', {
  defaults = { lazy = true },
  ui = { border = 'rounded' },
  -- install = { colorscheme = { 'kanagawa' } },
  checker = { enabled = false },
  change_detection = {
    notify = false
  },
  performance = {
    rtp = {
      disabled_plugins = {
        -- "gzip",
        "matchit",
        "netrwPlugin",
        -- "tarPlugin",
        "tohtml",
        "tutor",
        -- "zipPlugin",
      },
    },
  }
})

