(module config.plugin.theme
  {autoload {core aniseed.core
             nvim aniseed.nvim
             kanagawa kanagawa
             onedark onedark
             nightfox nightfox}})

(kanagawa.setup
  {:dimInactive true
   :globalStatus true})

(nightfox.setup
  {:options {:dim_inactive true}})

(onedark.setup
  {:style :darker})
