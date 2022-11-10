(module config.plugin.lspconfig
  {autoload {lsp lspconfig
             core aniseed.core
             tb telescope.builtin
             util lspconfig.util
             u config.util
             navic nvim-navic
             cmplsp cmp_nvim_lsp
             wk which-key
             fidget fidget
             mason mason
             mason-lspconfig mason-lspconfig
             fzf fzf-lua}})

(vim.api.nvim_create_augroup :LspGroup {:clear true})

;symbols to show for lsp diagnostics
(let [error "DiagnosticSignError"
      warn  "DiagnosticSignWarn"
      info  "DiagnosticSignInfo"
      hint  "DiagnosticSignHint"]
  (vim.fn.sign_define error {:text "" :texthl error})
  (vim.fn.sign_define warn  {:text "" :texthl warn})
  (vim.fn.sign_define info  {:text "" :texthl info})
  (vim.fn.sign_define hint  {:text "" :texthl hint}))

(defn setup-document-highlight [client bufnr]
  (vim.api.nvim_create_autocmd
    :CursorHold
    {:group :LspGroup
     :buffer bufnr
     :callback vim.lsp.buf.document_highlight})
  (vim.api.nvim_create_autocmd
    :CursorMoved
    {:group :LspGroup
     :buffer bufnr
     :callback vim.lsp.buf.clear_references}))

(fn try-until-succeed
  [interval check-fn success-fn]
  (let [timer (vim.loop.new_timer)]
    (timer:start 
      interval interval #(when (check-fn)
                           (success-fn)
                           (timer:stop)
                           (timer:close)))))

(fn restart-lsp [client bufnr]
  (vim.notify "LSP Restarting")
  (vim.api.nvim_clear_autocmds {:group :LspGroup :buffer bufnr})
  (client.stop)
  (try-until-succeed
    300
    #(vim.lsp.client_is_stopped client.id) 
    #(vim.schedule #(vim.cmd :LspStart))))

(local float-opts {:border :rounded})

(fn get-wk-bindings [client bufnr]
  {:g {:d [tb.lsp_definitions "Go to definition"]
       :r [tb.lsp_references "LSP rerefences"]
       :t [tb.lsp_type_definitions "Type definition"]}
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
                  :D [tb.diagnostics "Workspace diagnostics"]
                  :R [#(restart-lsp client bufnr) "Restart LSP"]}}
   :K [vim.lsp.buf.hover "Hover doc"]})

(let [handlers {"textDocument/publishDiagnostics"
                (vim.lsp.with
                  vim.lsp.diagnostic.on_publish_diagnostics
                  {:virtual_text false
                   :signs true
                   :underline true
                   :update_in_insert false
                   :severity_sort true})

                "textDocument/codeLens"
                (vim.lsp.with
                  vim.lsp.diagnostic.on_publish_diagnostics
                  {:virtual_text false})

                "textDocument/hover" (vim.lsp.with vim.lsp.handlers.hover float-opts)

                "textDocument/signatureHelp"
                (vim.lsp.with vim.lsp.handlers.signature_help float-opts)}
      capabilities (cmplsp.default_capabilities
                     (vim.lsp.protocol.make_client_capabilities))
      on_attach (fn [client bufnr]
                  (when client.server_capabilities.documentHighlightProvider
                   (setup-document-highlight client bufnr))
                 (when client.server_capabilities.documentSymbolProvider
                   (navic.attach client bufnr))
                 (wk.register (get-wk-bindings client bufnr)
                              {:noremap true :buffer bufnr}))
      defaults {:on_attach on_attach
                :handlers handlers
                :capabilities capabilities}]
  ;; Clojure
  (lsp.clojure_lsp.setup (u.merge 
                           defaults
                           {:root_dir #(vim.fn.getcwd)
                            :init_options {:signatureHelp true
                                           :codeLens true}
                            :flags {:debounce_text_changes 150}
                            :cmd ["/usr/local/bin/clojure-lsp"] }))
  (lsp.yamlls.setup 
    (u.merge
      defaults
      {:settings
       {:yaml {:schemas
               {"https://json.schemastore.org/github-workflow.json"
                ".github/workflows/*"}}}}))

  ;; JavaScript and TypeScript
  (lsp.tsserver.setup defaults)
  ;; html / css / json
  (lsp.cssls.setup defaults)
  ;;
  (lsp.html.setup defaults)
  ;;
  (lsp.jsonls.setup defaults)
  )

(mason.setup {:ui {:border :rounded}})
(mason-lspconfig.setup {})
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
