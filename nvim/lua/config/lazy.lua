local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not (vim.uv or vim.loop).fs_stat(lazypath) then
  vim.fn.system({
    "git",
    "clone",
    "--filter=blob:none",
    "https://github.com/folke/lazy.nvim.git",
    "--branch=stable", -- latest stable release
    lazypath,
  })
end
vim.opt.rtp:prepend(lazypath)

-- load lazy
-- loads everything with name `config.plugins`
-- and everything in directory `config.plugins`
require("lazy").setup("config.plugins", {
  defaults = { lazy = true },
  ui = { border = "rounded" },
  install = { colorscheme = { "kanagawa" } },
  checker = {
    -- automatically check for plugin updates
    enabled = true,
    notify = false,
    frequency = 3600, -- check for updates every hour
  },
  change_detection = {
    notify = false,
  },
  performance = {
    rtp = {
      disabled_plugins = {
        "netrw",
        "netrwPlugin",
        "netrwSettings",
        "netrwFileHandlers",
      },
    },
  },
})
