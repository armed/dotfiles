(module config.plugin.gitsigns
  {autoload {gs gitsigns
             wk which-key}})

(gs.setup
  {:current_line_blame_opts {:delay 300}
   :on_attach
   (fn [bufnr]
     (let [keys {:h {:name "Gitsigns"
                     :b [#(gs.blame_line {:full true}) "Blame line"]
                     :p [gs.preview_hunk "Preview hunk"]
                     :s [":Gitsigns stage_hunk<CR>" "Stage hunk"]
                     :u [gs.undo_stage_hunk "Undo stage hunk"]
                     :r [":Gitsigns reset_hunk<CR>" "Reset hunk"]
                     :S [gs.stage_buffer "Stage buffer"]
                     :R [gs.reset_buffer "Reset buffer"]
                     :t {:name "Toggle"
                         :b [gs.toggle_current_line_blame "Curent line blame"]
                         :d [gs.toggle_deleted "Deleted"]}
                     :d [gs.diffthist "Diff history"]
                     :D [#(gs.diffhis "~") "Diff ~history"]}}]

       (wk.register keys {:prefix :<leader>})))})
