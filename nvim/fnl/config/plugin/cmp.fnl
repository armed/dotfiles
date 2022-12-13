(module config.plugin.cmp
  {autoload {nvim aniseed.nvim
             ;; luasnip luasnip
             lspkind lspkind
             ;; snipmate luasnip.loaders.from_snipmate
             cmp cmp}})

;; (snipmate.lazy_load)

(def- cmp-srcs
  [{:name :nvim_lsp}
   ;; {:name :luasnip}
   ;; {:name :conjure}
   {:name :cmdline}
   {:name :buffer}
   {:name :path}
   ;; {:name :nvim_lua}
   {:name :calc}])

;; Setup cmp with desired settings
(fn has-words-before []
  (let [(line col) (unpack (vim.api.nvim_win_get_cursor 0))]
    (and (not= col 0)
         (= (: (: (. (vim.api.nvim_buf_get_lines 0 (- line 1) line true) 1) 
                  :sub col col) 
               :match "%s") 
            nil))))

(cmp.setup {:formatting
            {:format (lspkind.cmp_format {:mode :symbol
                                          :maxwidth 50
                                          :ellipsis_char "..."
                                          :before (fn [entry vim-item]
                                                    vim-item)})
             :formatting {:fields [:menu :abbr :kind]}}
            :window {:documentation (cmp.config.window.bordered)
                     :completion (cmp.config.window.bordered)}
            :mapping {:<C-k> (cmp.mapping.select_prev_item)
                      :<C-j> (cmp.mapping.select_next_item)
                      :<C-b> (cmp.mapping.scroll_docs (- 4))
                      :<C-f> (cmp.mapping.scroll_docs 4)
                      :<C-Space> (cmp.mapping.complete)
                      :<C-e> (cmp.mapping.close)
                      :<CR> (cmp.mapping.confirm {:behavior cmp.ConfirmBehavior.Insert
                                                  :select true})
                      :<Tab> (cmp.mapping (fn [fallback]
                                            (if
                                              (cmp.visible) (cmp.select_next_item)
                                              ;; (luasnip.expand_or_jumpable) (luasnip.expand_or_jump)
                                              (has-words-before) (cmp.complete)
                                              :else (fallback)))
                                          {1 :i 2 :s})
                      :<S-Tab> (cmp.mapping (fn [fallback]
                                              (if
                                                (cmp.visible) (cmp.select_prev_item)
                                                ;; (luasnip.jumpable -1) (luasnip.jump -1)
                                                :else (fallback)))
                                            {1 :i 2 :s})}
            ;; :snippet {:expand (fn [args]
            ;;                     (luasnip.lsp_expand args.body))}
            :sources cmp-srcs})

(cmp.setup.cmdline 
  ":"
  {:mapping (cmp.mapping.preset.cmdline)
   :sources (cmp.config.sources [{:name :path}]
                                [{:name :cmdline
                                  :option {:ignore_cmds [:Man
                                                         "!"]}}])})

(cmp.setup.cmdline "/" {:mapping (cmp.mapping.preset.cmdline)
                        :sources [{:name :buffer}]})

(nvim.ex.hi "CmpItemMenu ctermfg=7 guifg=#b1b1b1")
