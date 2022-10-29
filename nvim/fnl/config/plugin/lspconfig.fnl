(module config.plugin.lspconfig
  {autoload {lsp lspconfig
             tb telescope.builtin
             util lspconfig.util
             u config.util
             cmplsp cmp_nvim_lsp
             wk which-key
             fidget fidget
             navic nvim-navic
             mason mason
             mason-lspconfig mason-lspconfig
             fzf fzf-lua
             conjure conjure}})

;symbols to show for lsp diagnostics
(let [error "DiagnosticSignError"
      warn  "DiagnosticSignWarn"
      info  "DiagnosticSignInfo"
      hint  "DiagnosticSignHint"]
  (vim.fn.sign_define error {:text "" :texthl error})
  (vim.fn.sign_define warn  {:text "" :texthl warn})
  (vim.fn.sign_define info  {:text "" :texthl info})
  (vim.fn.sign_define hint  {:text "" :texthl hint}))

(defn create-hl-group [bufnr]
  (let [group :lsp_document_highlight
        hl-events [:CursorHold :CursorMoved]]
    (vim.api.nvim_create_augroup group {:clear true})
    (vim.api.nvim_create_autocmd :CursorHold
                                 {:group group
                                  :buffer bufnr
                                  :callback vim.lsp.buf.document_highlight})
    (vim.api.nvim_create_autocmd :CursorMoved
                                 {:group group
                                  :buffer bufnr
                                  :callback vim.lsp.buf.clear_references})))

(defn setup-document-highlight [client bufnr]
  (let [(status-ok highlight-supported) 
        (pcall #(client.supports_method :textDocument/documentHighlight))]
    (when (and status-ok highlight-supported)
      (create-hl-group bufnr))))

(let [handlers {"textDocument/publishDiagnostics"
                (vim.lsp.with
                  vim.lsp.diagnostic.on_publish_diagnostics
                  {:virtual_text true
                   :signs true
                   :underline true
                   :update_in_insert false
                   :severity_sort true})
                "textDocument/codeLens"
                (vim.lsp.with
                  vim.lsp.diagnostic.on_publish_diagnostics
                  {:virtual_text true})
                "textDocument/hover"
                (vim.lsp.with
                  vim.lsp.handlers.hover
                  {:border "double"})
                "textDocument/signatureHelp"
                (vim.lsp.with
                  vim.lsp.handlers.signature_help
                  {:border "single"})}

      capabilities (cmplsp.default_capabilities
                     (vim.lsp.protocol.make_client_capabilities))
      bindings 
      {:g {:d [tb.lsp_definitions "Go to definition"]
           :r [tb.lsp_references "LSP rerefences"]
           :t [tb.lsp_type_definitions "Type definition"]}
       :<leader> {:l {:r [vim.lsp.buf.rename "Rename"]
                      :l [vim.lsp.buf.signature_help "LSP Signature"]
                      :a [vim.lsp.buf.code_action "Code actions"]
                      :s [tb.lsp_document_symbols "Document symbols"]
                      :S [tb.lsp_dynamic_workspace_symbols "Workspace symbols"]
                      :f [vim.lsp.buf.format "Format buffer"]
                      :d [#(tb.diagnostics {:bufnr 0}) "Document diagnostics"]
                      :D [tb.diagnostics "Workspace diagnostics"]
                      :R ["<cmd>LspRestart<cr>" "Restart LSP"]}}
       :K [vim.lsp.buf.hover "Hover doc"]}
      on_attach (fn [client bufnr]
                  ;; (float-diagnostic bufnr)
                  (setup-document-highlight client bufnr)
                  (when client.server_capabilities.documentSymbolProvider
                    (navic.attach client bufnr))
                  (wk.register bindings {:noremap true
                                         :buffer bufnr}))
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
(mason-lspconfig.setup)
(fidget.setup {})
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
