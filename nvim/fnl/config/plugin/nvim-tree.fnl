(module config.plugin.nvim-tree
  {autoload {wk which-key
             nvim-tree nvim-tree}})

(local shl vim.api.nvim_set_hl)

(shl 0 "NvimTreeGitDirty" {:fg "#e28743"})
(shl 0 "NvimTreeGitStaged" {:fg "#388ecb"})
(shl 0 "NvimTreeGitNew" {:fg "#1eb079"})
(shl 0 "NvimTreeGitDeleted" {:fg "#e37474"})
(shl 0 "NvimTreeRootFolder" {:fg "#d078cf"})

(nvim-tree.setup 
  {:sync_root_with_cwd true
   :diagnostics {:enable true
                 :show_on_dirs true}
   :respect_buf_cwd false
   :hijack_unnamed_buffer_when_opening true
   :update_focused_file {:enable true 
                         :update_root false}
   :view {:signcolumn "yes"
          :preserve_window_proportions true}
   :renderer {:indent_markers {:enable true}
              :root_folder_modifier ":t"
              :highlight_git true
              :icons {:glyphs {:git {:unstaged ""
                                     :staged ""
                                     :unmerged ""
                                     :renamed "➜"
                                     :untracked ""
                                     :deleted ""
                                     :ignored "◌"}}}}})

(wk.register {:e [::NvimTreeToggle<cr> "Toggle Nvim Tree"]}
             {:prefix :<leader>})
