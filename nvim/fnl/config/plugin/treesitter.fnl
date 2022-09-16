(module config.plugin.treesitter
  {autoload {treesitter nvim-treesitter.configs}})

(treesitter.setup 
  {:ensure_installed ["c" "lua" "rust" "clojure" "fennel" "norg"]
   :highlight {:enable true
               :additional_vim_regex_highlighting true}
   :indent {:enable true}
   :rainbow {:enable true
             :extended_mode true
             :max_file_lines nil}
   :refactor {:enable true
              :highlight_definitions {:enable true
                                      :clear_on_cursor_move true}
              :navigation {:enable true}}
   :textobjects {:select {:enable true}
                 :lsp_interop {:enable false}
                 :lookahead true
                 :keymaps {:af "@function.outer"
                           :if "@function.inner"
                           :ac "@class.outer"
                           :ic "@class.inner"}}})
