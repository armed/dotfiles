(module config.plugin.treesitter
  {autoload {treesitter nvim-treesitter.configs}})

(treesitter.setup 
  {:highlight {:enable true}
   :indent {:enable true}
   :ensure_installed "clojure"
   :refactor {:enable true
              :highlight_definitions {:enable true
                                      :clear_on_cursor_move true}}})
