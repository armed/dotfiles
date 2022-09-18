(module config.init
  {autoload {nvim aniseed.nvim}})

(require :config.core)
(require :config.mapping)
(require :config.plugin)

(nvim.ex.colorscheme "tokyonight-night")

;; optional module with local overrides
(pcall #(require :config.local))

