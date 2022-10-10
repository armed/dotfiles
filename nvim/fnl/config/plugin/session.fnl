(module config.plugin.session
  {autoload {telescope telescope
             session session_manager
             scfg session_manager.config
             tree nvim-tree
             auto-save auto-save
             wk which-key}})

(session.setup {;:autoload_mode scfg.AutoloadMode.CurrentDir
                :autosave_only_in_session true})

(let [session-group (vim.api.nvim_create_augroup "SessionGroup" {})]
  (vim.api.nvim_create_autocmd
    ["User"]
    {:pattern [ "SessionLoadPre" "SessionSavePre" ]
     :group session-group
     :callback (fn [] (auto-save.save) (auto-save.off))})
  (vim.api.nvim_create_autocmd
    ["User"]
    {:pattern [ "SessionSavePost" ]
     :group session-group
     :callback #(tree.open)})
  (vim.api.nvim_create_autocmd
    ["User"]
    {:pattern [ "SessionLoadPost" ]
     :group session-group
     :callback (fn []
                 (auto-save.on)
                 (tree.open))}))

(wk.register {:S {:name "Session"
                  :s [session.save_current_session "Save"]
                  :f [session.load_session "Load"]
                  :d [session.delete_session "Delete"]}}
             {:prefix :<leader>})

