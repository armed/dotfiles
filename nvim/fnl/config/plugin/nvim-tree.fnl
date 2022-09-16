(module config.plugin.nvim-tree
  {autoload {nvim aniseed.nvim
             nvim-tree nvim-tree}})

(nvim.set_keymap :n :<leader>e ":NvimTreeToggle<CR>" {:noremap true})

(nvim-tree.setup 
  {:sync_root_with_cwd true
   :respect_buf_cwd true
   :update_focused_file {:enable true 
                         :update_root true}
   :renderer {:indent_markers {:enable true}
              :icons {:git_placement :signcolumn
                      :glyphs {:git {:unstaged "✗"
                                     :staged "✓"
                                     :unmerged ""
                                     :renamed "➜"
                                     :untracked ""
                                     :deleted ""
                                     :ignored "◌"}}}}})


