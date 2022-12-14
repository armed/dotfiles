(module config.plugin.conjure
  {autoload {eval conjure.eval
             core aniseed.core
             extract conjure.extract
             wk which-key}})

(set vim.g.conjure#mapping#doc_word false)
;; (set nvim.g.conjure#client#clojure#nrepl#eval#auto_require false)
(set vim.g.conjure#client#clojure#nrepl#connection#auto_repl#enabled false)
(set vim.g.conjure#highlight#enabled true)
(set vim.g.conjure#highlight#timeout 150)
(set vim.g.conjure#log#wrap true)
(set vim.g.conjure#log#jump_to_latest#enabled true)
(set vim.g.conjure#client#clojure#nrepl#eval#raw_out true)
(set vim.g.conjure#client#clojure#nrepl#test#raw_out true)
(set vim.g.conjure#client#clojure#nrepl#test#runner "kaocha")
(set vim.g.conjure#log#jump_to_latest#cursor_scroll_position "center")
(set vim.g.conjure#log#hud#enabled false)

(fn conjure-eval [form]
  (eval.eval-str {:code form :origin :custom_command}))

(fn conjure-eval-fn [form]
  (fn []
    (conjure-eval form)))

(fn conjure-word []
  (. (extract.word) :content))

(fn conjure-form [root?]
  (. (extract.form {:root? root?}) :content))

(local portal-cmds
  {:open (conjure-eval-fn
           "(do (ns dev)
              ((requiring-resolve 'portal.api/close))
              (def portal ((requiring-resolve 'portal.api/open)
                           {:theme :portal.colors/nord}))
              (add-tap (requiring-resolve 'portal.api/submit)))")
   :clear (conjure-eval-fn "(portal.api/clear)")
   :last_exception (conjure-eval-fn "(tap> (Throwable->map *e))")
   :tap_word (fn []
               (local word (conjure-word))
               (conjure-eval (.. "(tap> " word ")")))
   :tap_form (fn []
               (local form (conjure-form false))
               (conjure-eval (.. "(tap> " form ")")))
   :tap_root_form (fn []
                    (local form (conjure-form true))
                    (conjure-eval (.. "(tap> " form ")")))})	

(local mappings
  {:s {:o [::ConjureOutSubscribe<cr> "Subscribe to output"]
       :O [::ConjureOutUnsubscribe<cr> "Unsubscribe from output"]}
   :p {:name :Portal
       :p [portal-cmds.open "Portal open"]
       :c [portal-cmds.clear "Portal clear"]
       :e [portal-cmds.last_exception "Tap last exception"]
       :w [portal-cmds.tap_word "Tap word"]
       :f [portal-cmds.tap_form "Tap current form"]
       :r [portal-cmds.tap_root_form "Tap root form"]}})

(wk.register mappings {:prefix :<localleader>})

(let [grp (vim.api.nvim_create_augroup :conjure_hooks {:clear true})]
  (vim.api.nvim_create_autocmd 
    "BufNewFile"
    {:group grp
     :pattern "conjure-log-*"
     :callback (fn [event]
                 (vim.defer_fn 
                   (fn []
                     (vim.lsp.for_each_buffer_client 
                       event.buf
                       (fn [_ client-id bufnr]
                         (vim.lsp.buf_detach_client bufnr client-id))))
                   1000)
                 (vim.diagnostic.disable 0))}))
