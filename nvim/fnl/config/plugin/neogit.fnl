(module config.plugin.neogit
  {autoload {nvim aniseed.nvim
             wk which-key
             neogit neogit}})

(neogit.setup {})

(wk.register {:g [neogit.open "Neogit"]} {:prefix :<leader>})
