(module config.plugin.treesitter
  {autoload {treesitter nvim-treesitter.configs}})

(treesitter.setup 
  {:ensure_installed ["lua" "clojure" "fennel" "norg"]
   :highlight {:enable true
               :additional_vim_regex_highlighting false}
   :indent {:enable true}
   :rainbow {:enable true
             :extended_mode true
             :max_file_lines nil}
   ;; :refactor {:enable true
   ;;            :highlight_definitions {:enable true
   ;;                                    :clear_on_cursor_move true}
   ;;            :navigation {:enable true}}
   ;; :textobjects {:select {:enable true}
   ;;               :lsp_interop {:enable true}
   ;;               :lookahead true
   ;;               :keymaps {:af "@function.outer"
   ;;                         :if "@function.inner"
   ;;                         :ac "@class.outer"
   ;;                         :ic "@class.inner"}}
   :playground {:enable true
                :disable {}
                :updatetime 25
                :persist_queries false
                :keybindings {:toggle_query_editor :o
                              :toggle_hl_groups :i
                              :toggle_injected_languages :t
                              :toggle_anonymous_nodes :a
                              :toggle_language_display :I
                              :focus_language :f
                              :unfocus_language :F
                              :update :R
                              :goto_node :<cr>
                              :show_help "?"}}})
