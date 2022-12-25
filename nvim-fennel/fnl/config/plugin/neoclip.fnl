(module config.plugin.neoclip
  {autoload {neoclip neoclip
             a aniseed.core
             wk which-key}})

(fn whitespace? [line]
  (not= (vim.fn.match line "^\\s*$") -1))

(fn omit-unwanted [tbl]
  (not (a.some (fn [t]
                 (or (= (length t) 1)
                     (whitespace? t)))
               tbl.event.regcontents)))

(neoclip.setup {:filter omit-unwanted
                :continuous_sync true
                :enable_persistent_history true
                :keys {:telescope {:i {:paste_behind :<C-S-p>}}}})

(local keys {:c [":Telescope neoclip initial_mode=normal<cr>" "Neoclip"]})
(wk.register keys {:prefix :<leader>})

