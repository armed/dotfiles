(module config.plugin.neo-tree
  {autoload {wk which-key
             nt neo-tree}})

(nt.setup
  {:filesystem {:use_libuv_file_watcher true}})

(wk.register {:e [::NeoTreeFocusToggle<cr> "Toggle Nvim Tree"]}
             {:prefix :<leader>})
