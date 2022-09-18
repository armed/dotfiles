(module config.plugin.colorizer
  {autoload {core aniseed.core
             colorizer colorizer}})

(set nvim.o.termguicolors true)
(colorizer.setup)
