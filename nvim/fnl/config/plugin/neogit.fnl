(module config.plugin.neogit
  {autoload {nvim aniseed.nvim
             wk which-key
             neogit neogit}})

(neogit.setup {:integrations {:diffview true}
                 :disable_commit_confirmation true
               :signs {:section ["" ""]
                       :item ["" ""]}})

(wk.register {:g [neogit.open "Neogit"]} {:prefix :<leader>})
