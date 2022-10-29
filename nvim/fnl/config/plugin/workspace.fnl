(module config.plugin.workspace
  {autoload {w workspaces
             s sessions
             wk which-key}})

(s.setup {:session_filepath ".nvim_session"})
(w.setup {:hooks {:open (fn []
                          (when (not (s.load nil {:silent true}))
                            (s.save nil {:silent true}))
                          ;; (vim.cmd :NeoTreeShow)
                          )}})

(wk.register {:S {:name "Workspaces"
                  :a [w.add "Add"]
                  :r [w.remove "Remove"]
                  :f [":Telescope workspaces<cr>" "List"]}}
             {:prefix :<leader>})

