(module config.ayu
  {autoload {nvim aniseed.nvim
             onedark onedark}})

(onedark.setup
  {:style :darker})

(nvim.ex.colorscheme "onedark")
