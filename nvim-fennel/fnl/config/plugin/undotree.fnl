(module config.plugin.undotree
  {autoload {nvim aniseed.nvim
             util config.util
             wk which-key
             str aniseed.string}})

(wk.register {:u [::UndotreeToggle<cr> "Undo tree"]}
             {:prefix :<leader>})
