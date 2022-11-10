(module config.plugin.neo-tree
  {autoload {wk which-key
             wp window-picker
             cp catppuccin.palettes
             nt neo-tree}})

(local palette (cp.get_palette :mocha))

(nt.setup
  {:window {:mappings {:<space> false
                       :<tab> :toggle_node
                       ;:S :split_with_window_picker
                       ;:s :vsplit_with_window_picker
                       }}
   :filesystem {:use_libuv_file_watcher true
                :hide_gitignored true
                :cwd_target {:sidebar "tab"
                             :current "tab"}
                :follow_current_file true
                :group_empty_dirs true}})

(wp.setup
  {:autoselect_one true
   :include_current false
   :other_win_hl_color palette.blue
   :fg_color palette.crust
   :filter_rules {:bo {:filetype [:neo-tree :neo-tree-popup :notify]
                       :buftype [:terminal :quickfix]}
                  :file_name_contains ["conjure-log-*"]}})

(wk.register {:e [::NeoTreeFocusToggle<cr> "Toggle Neo Tree"]
              :E [::NeoTreeFocus<cr> "Focus Neo Tree"]}
             {:prefix :<leader>})
