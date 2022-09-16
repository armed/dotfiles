(module config.plugin.lspconfiglsp
  {autoload {nvim aniseed.nvim
             lsp lspconfig
             util lspconfig.util
             cmplsp cmp_nvim_lsp
             wk which-key
             fzf fzf-lua
             conjure conjure}})

;symbols to show for lsp diagnostics
(defn define-signs
  [prefix]
  (let [error (.. prefix "SignError")
        warn  (.. prefix "SignWarn")
        info  (.. prefix "SignInfo")
        hint  (.. prefix "SignHint")]
  (vim.fn.sign_define error {:text "" :texthl error})
  (vim.fn.sign_define warn  {:text "" :texthl warn})
  (vim.fn.sign_define info  {:text "" :texthl info})
  (vim.fn.sign_define hint  {:text "" :texthl hint})))

(if (= (nvim.fn.has "nvim-0.6") 1)
  (define-signs "Diagnostic")
  (define-signs "LspDiagnostics"))

(defn create-hl-group [bufnr]
  (local group :lsp_document_highlight)
  (local hl-events [:CursorHold :CursorHoldI])
  (local (ok hl-autocmds)
    (pcall nvim.get_autocmds
           {:group group :buffer bufnr :event hl-events}))

  (when (not (and ok (> (length hl-autocmds) 0)))
    (nvim.create_augroup group {:clear false})
    (nvim.create_autocmd :CursorHold
                         {:group group
                          :buffer bufnr
                          :callback vim.lsp.buf.document_highlight})
    (nvim.create_autocmd :CursorHoldI
                         {:group group
                          :buffer bufnr
                          :callback vim.lsp.buf.document_highlight})
    (nvim.create_autocmd :CursorMoved
                         {:group group
                          :buffer bufnr
                          :callback vim.lsp.buf.clear_references})))

(defn setup-document-highlight [client bufnr]
  (let [(status-ok highlight-supported) 
        (pcall (fn [] (client.supports_method :textDocument/documentHighlight)))]
    (when (and status-ok highlight-supported)
      (create-hl-group bufnr))))	

(comment 
  vim.lsp
  (nvim.get_autocmds {:group :lsp_document_highlight 
                      :buffer 1 
                      :event [:CursorHold :CursorHoldI]})
  
  (create-hl-group 12))

(let [handlers {"textDocument/publishDiagnostics"
                (vim.lsp.with
                  vim.lsp.diagnostic.on_publish_diagnostics
                  {:virtual_text false
                   :signs true
                   :underline true
                   :update_in_insert false
                   :severity_sort false})
                "textDocument/hover"
                (vim.lsp.with
                  vim.lsp.handlers.hover
                  {:border "single"})
                "textDocument/signatureHelp"
                (vim.lsp.with
                  vim.lsp.handlers.signature_help
                  {:border "single"})}
      capabilities (cmplsp.update_capabilities (vim.lsp.protocol.make_client_capabilities))
      bindings {:g {:d [fzf.lsp_definitions "Go to definition"]
                    :r [fzf.lsp_references "LSP rerefences"]
                    :t [fzf.typedefs "Type definition"]}
                :<leader> { :l {:r [vim.lsp.buf.rename "Rename"]
                                :a [fzf.lsp_code_actions "Code actions"]
                                :s [fzf.lsp_document_symbols "Document symbols"]
                                :S [fzf.lsp_live_workspace_symbols "Workspace symbols"]
                                :f [vim.lsp.buf.formatting "Format buffer"]}}
                :<localleader> {:E [":ConjureEvalMotion<cr>" "Eval motion"]}
                :K [vim.lsp.buf.hover "Hover doc"]}
      on_attach (fn [client bufnr]
                  (setup-document-highlight client bufnr)
                  (wk.register bindings {:noremap true
                                         :buffer bufnr}))]

  ;; Clojure
  (lsp.clojure_lsp.setup {:on_attach on_attach
                          :cmd ["/usr/local/bin/clojure-lsp"]
                          ;; :handlers handlers
                          :capabilities capabilities})

  ;; JavaScript and TypeScript
  (lsp.tsserver.setup {:on_attach on_attach
                       ;; :handlers handlers
                       :capabilities capabilities})

  ;; html / css / json
  (lsp.cssls.setup {:on_attach on_attach
                    ;; :handlers handlers
                    :capabilities capabilities
                    :cmd ["vscode-css-languageserver" "--stdio"]})

  (lsp.html.setup {:on_attach on_attach
                   ;; :handlers handlers
                   :capabilities capabilities
                   :cmd ["vscode-html-languageserver" "--stdio"]})

  (lsp.jsonls.setup {:on_attach on_attach
                     ;; :handlers handlers
                     :capabilities capabilities
                     :cmd ["vscode-json-languageserver" "--stdio"]})

  ;; Rust
  (lsp.rust_analyzer.setup {:on_attach on_attach
                            ;; :handlers handlers
                            :capabilities capabilities
                            :cmd ["rustup" "run" "nightly" "rust-analyzer"]}))
