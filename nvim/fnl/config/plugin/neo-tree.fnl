(module config.plugin.neo-tree
  {autoload {wk which-key
             nt neo-tree}})

(nt.setup
  {:window {:mappings {:<space> false
                       :<tab> :toggle_node}}
   :filesystem {:use_libuv_file_watcher true
                :hide_gitignored true
                :bind_to_cwd true
                :cwd_target {:sidebar "global"
                             :current "global"}
                :follow_current_file true
                :group_empty_dirs true}})

(wk.register {:e [::NeoTreeFocusToggle<cr> "Toggle Nvim Tree"]}
             {:prefix :<leader>})
