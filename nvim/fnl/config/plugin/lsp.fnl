(module config.plugin.lsp
  {autoload {lsp lsp-zero
             navic nvim-navic
             tb telescope.builtin
             nvim aniseed.nvim
             wk which-key
             : glance
             : fidget
             : mason}})

(glance.setup {:border {:enable true
                        :top_char "―"
                        :bottom_char "―"}})
(lsp.preset :recommended)
(lsp.set_preferences {:set_lsp_keymaps false
                      :sign_icons {:error :
                                   :warn :
                                   :info :
                                   :hint :}})
(lsp.ensure_installed [:clojure_lsp])

(nvim.create_augroup :LspGroup {:clear true})

(fn setup-document-highlight [client bufnr]
  (nvim.create_autocmd
    :CursorHold
    {:group :LspGroup
     :buffer bufnr
     :callback vim.lsp.buf.document_highlight})
  (nvim.create_autocmd
    :CursorMoved
    {:group :LspGroup
     :buffer bufnr
     :callback vim.lsp.buf.clear_references}))

(local float-opts {:border :rounded})

(fn get-wk-bindings [client bufnr]
  {;:g {:d [tb.lsp_definitions "Go to definition"]
   ;    :r [tb.lsp_references "LSP rerefences"]
   ;    :t [tb.lsp_type_definitions "Type definition"]}
   :g {:d ["<cmd>Glance definitions<cr>" "Go to definition"]
       :r ["<cmd>Glance references<cr>" "LSP references"]
       :t ["<cmd>glance type_definitions<cr>" "LSP type definitions"]
       :i ["<cmd>glance implementations<cr>" "LSP implementations"]}
   :<leader> {:l {:r [vim.lsp.buf.rename "Rename"]
                  :n [#(vim.diagnostic.goto_next {:float float-opts})
                      "Next diagnostics"]
                  :N [#(vim.diagnostic.goto_prev {:float float-opts})
                      "Prev diagnostics"]
                  :l [#(vim.diagnostic.open_float float-opts) 
                      "Line diagnostic"]
                  :a [vim.lsp.buf.code_action "Code actions"]
                  :s [tb.lsp_document_symbols "Document symbols"]
                  :S [tb.lsp_dynamic_workspace_symbols "Workspace symbols"]
                  :f [vim.lsp.buf.format "Format buffer"]
                  :d [#(tb.diagnostics {:bufnr 0}) "Document diagnostics"]
                  :D [tb.diagnostics "Workspace diagnostics"]}}
   :K [vim.lsp.buf.hover "Hover doc"]})

(fn on-attach [client bufnr]
  (when client.server_capabilities.documentHighlightProvider
    (setup-document-highlight client bufnr))
  (when client.server_capabilities.documentSymbolProvider
    (navic.attach client bufnr))
  ;; (when client.server_capabilities.codeLensProvider
  ;;   (setup-codelens client bufnr))
  (wk.register (get-wk-bindings client bufnr)
               {:noremap true :buffer bufnr}))

(lsp.on_attach on-attach)
(lsp.configure :clojure_lsp {:root_dir #(vim.fn.getcwd)})
(lsp.setup)

(fidget.setup {:window {:blend 0}})
(navic.setup {:icons {:File " "
                      :Module " "
                      :Namespace " "
                      :Package " "
                      :Class " "
                      :Method " "
                      :Property " "
                      :Field " "
                      :Constructor " "
                      :Enum " "
                      :Interface " "
                      :Function " "
                      :Variable " "
                      :Constant " "
                      :String " "
                      :Number " "
                      :Boolean " "
                      :Array " "
                      :Object " "
                      :Key " "
                      :Null " "
                      :EnumMember " "
                      :Struct " "
                      :Event " "
                      :Operator " "
                      :TypeParameter " "}})

