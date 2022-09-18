(module config.plugin.neogit
  {autoload {nvim aniseed.nvim
             wk which-key
             neogit neogit}})

(neogit.setup {:integrations {:diffview true}
               :signs {:section ["" ""]
                       :item ["" ""]}})

(wk.register {:g [neogit.open "Neogit"]} {:prefix :<leader>})
