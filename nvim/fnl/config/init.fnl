(module config.init
  {autoload {nvim aniseed.nvim}})

(require :config.core)
(require :config.mapping)
(require :config.plugin)

(nvim.ex.colorscheme "nightfox")
