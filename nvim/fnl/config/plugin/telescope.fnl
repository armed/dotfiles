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
                             :<C-j> actions.move_selection_next
                             :<C-k> actions.move_selection_previous}}
              :vimgrep_arguments  ["rg"
                                   "--color=never"
                                   "--no-heading"
                                   "--with-filename"
                                   "--line-number"
                                   "--column"
                                   "--smart-case"
                                   "--trim"]}
   :extensions {:ui-select {1 (themes.get_dropdown {})}
                :fzf {:fuzzy true
                      :override_generic_sorter true
                      :override_file_sorter true
                      :case_mode :smart_case}}})

(telescope.load_extension "ui-select")
(telescope.load_extension "fzf")
(telescope.load_extension "zoxide")
(telescope.load_extension "neoclip")

(local keys {:f [tb.find_files "Find files"]
             :r [tb.resume "Resume last search"]
             :s {:name "Search for"
                 :z [telescope.extensions.zoxide.list "Recent dirs"]
                 :g [tb.live_grep "Live grep"]
                 :b [tb.buffers "Buffers"]
                 :r [tb.oldfiles "Recent files"]}})
(wk.register keys {:prefix :<leader>})
