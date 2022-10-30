(module config.plugin.workspace
  {autoload {ntsm neo-tree.sources.manager
             w workspaces
             util config.util
             wk which-key}})

(local session-file ".nvim_session")

(fn close-neo-tree []
  (ntsm.close_all))

(fn open-neo-tree []
  (ntsm.show :filesystem))

(util.set-global-option :ssop "sesdir,winsize,buffers,tabpages")

(fn session-exists []
  (= 1 (vim.fn.filewritable session-file)))

(fn save-session []
  (close-neo-tree)
  (vim.cmd (.. "mksession! " session-file)))

(fn load-session []
  (vim.cmd (.. "so " session-file))
  (open-neo-tree))

(w.setup {:hooks {:open_pre (fn [] (when (session-exists)
                                     (save-session)
                                     (vim.cmd "sil %bwipeout!")))
                  :open (fn [] (when (session-exists) 
                                 (load-session)))}})

(vim.api.nvim_create_autocmd
  :VimLeave {:callback #(when (session-exists)
                          (save-session))})

(vim.api.nvim_create_autocmd
  :VimEnter {:callback #(when (session-exists)
                          (vim.schedule load-session))})

(fn add-workspace []
  (save-session)
  (w.add))

(fn delete-workspace []
  (w.remove))

(wk.register {:S {:name "Sessions"
                  :a [add-workspace "Add"]
                  :r [delete-workspace "Remove"]
                  :f [w.open "List"]}}
             {:prefix :<leader>})

