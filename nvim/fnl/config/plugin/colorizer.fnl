(module config.plugin.colorizer
  {autoload {core aniseed.core
             nvim aniseed.nvim
             colorizer colorizer}})

(set nvim.o.termguicolors true)
(colorizer.setup)
