(module config.plugin.neoclip
  {autoload {nvim aniseed.nvim
             a aniseed.core
             neoclip neoclip
             nz neoclip.fzf
             wk which-key}})

(fn whitespace? [line]
  (not= (vim.fn.match line "^\\s*$") -1))

(fn omit-onwanted [tbl]
  (not (a.some (fn [t]
                 (or (= (length t) 1)
                     (whitespace? t)))
               tbl.event.regcontents)))

(neoclip.setup {:filter omit-onwanted 
                :keys {:telescope {:i {:paste_behind :<C-S-p>}}}})

(local keys {:c [":Telescope neoclip initial_mode=nomal<cr>" "Neoclip"]})
(wk.register keys {:prefix :<leader>})

