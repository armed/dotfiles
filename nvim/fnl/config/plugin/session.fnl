(module config.plugin.session
  {autoload {nvim aniseed.nvim
             telescope telescope
             session session_manager
             scfg session_manager.config
             tree nvim-tree
             auto-save auto-save
             wk which-key}})

(session.setup {:autoload_mode scfg.AutoloadMode.CurrentDir})

(let [session-group (nvim.create_augroup "SessionGroup" {})]
  (nvim.create_autocmd
    ["User"]
    {:pattern [ "SessionLoadPre" "SessionSavePre" ]
     :group session-group
     :callback (fn [] (auto-save.save) (auto-save.off))})
  (nvim.create_autocmd
    ["User"]
    {:pattern [ "SessionSavePost" ]
     :group session-group
     :callback #(tree.open)})
  (nvim.create_autocmd
    ["User"]
    {:pattern [ "SessionLoadPost" ]
     :group session-group
     :callback (fn []
                 (auto-save.save)
                 (auto-save.on)
                 (tree.open))}))

(wk.register {:S {:name "Session"
                  :s [session.save_current_session "Save"]
                  :f [session.load_session "Load"]
                  :d [session.delete_session "Delete"]}}
             {:prefix :<leader>})

