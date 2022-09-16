(module config.plugin.telescope
  {autoload {nvim aniseed.nvim
             telescope telescope
             themes telescope.themes
             actions telescope.actions
             tb telescope.builtin
             wk which-key}})

(telescope.setup
  {:defaults {:file_ignore_patterns ["node_modules" "target"]
              :mappings {:i {:<ESC> actions.close
                             :<C-k> actions.move_selection_next
                             :<C-j> actions.move_selection_previous}}
              :vimgrep_arguments  ["rg"
                                   "--color=never"
                                   "--no-heading"
                                   "--with-filename"
                                   "--line-number"
                                   "--column"
                                   "--smart-case"
                                   "--trim"]}
   :extensions {:ui-select {1 (themes.get_dropdown {})}}
   :pickers {:find_files {:find_command ["rg" 
                                         "--files" 
                                         "--iglob"
                                         "!.git"
                                         "--hidden"
                                         "--trim"]}}})

(telescope.load_extension "ui-select")

;; (local keys {:f [tb.find_files "Find files"]
;;              :s {:name "Search for"
;;                  :g [tb.live_grep "Live grep"]
;;                  :b [tb.buffers "Buffers"]
;;                  :h [tb.help_tags "Help tags"]}})
;; (wk.register keys {:prefix :<leader>})
