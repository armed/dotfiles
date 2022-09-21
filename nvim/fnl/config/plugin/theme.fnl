(module config.plugin.theme
  {autoload {core aniseed.core
             nvim aniseed.nvim
             tint tint
             kanagawa kanagawa
             nightfox nightfox}})

(kanagawa.setup
  {:dimInactive true
   :globalStatus true})

(nightfox.setup
  {:options {:dim_inactive true}})

(tint.setup {})
