(module config.plugin.nvim-tree
  {autoload {nvim aniseed.nvim
             nvim-tree nvim-tree}})

(nvim.set_keymap :n :<leader>e ":NvimTreeToggle<CR>" {:noremap true})

(nvim-tree.setup 
  {:sync_root_with_cwd true
   :respect_buf_cwd false
   :update_focused_file {:enable true 
                         :update_root false}
   :view {:signcolumn "yes"
          :preserve_window_proportions true}
   :renderer {:indent_markers {:enable true}
              :highlight_git true
              :icons {:git_placement :signcolumn
                      :glyphs {:git {:unstaged "✗"
                                     :staged "✓"
                                     :unmerged ""
                                     :renamed "➜"
                                     :untracked ""
                                     :deleted ""
                                     :ignored "◌"}}}}})


