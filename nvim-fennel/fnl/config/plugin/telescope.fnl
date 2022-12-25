(module config.plugin.telescope
  {autoload {telescope telescope
             themes telescope.themes
             actions telescope.actions
             tabs telescope-tabs
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
(telescope.load_extension "neoclip")
(telescope.load_extension "workspaces")

(local keys {:r [tb.resume "Resume last search"]
             :f {:name "Find"
                 :f [tb.find_files "Find files"]
                 :g [tb.live_grep "Live grep"]
                 :t [tabs.list_tabs "Tabs"]
                 :b [tb.buffers "Buffers"]
                 :r [#(tb.oldfiles {:cwd_only true}) "Recent files"]}})
(wk.register keys {:prefix :<leader>})
