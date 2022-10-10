(module config.plugin.fzf
  {autoload {fzf fzf-lua
             wk which-key}})

;; (local keys {:f [fzf.files "Find files"]
;;              :s {:name "Search for"
;;                  :r [fzf.oldfiles "Recent files"]
;;                  :g [fzf.live_grep "Live grep"]
;;                  :b [fzf.buffers "Buffers"] }})
;; (wk.register keys {:prefix :<leader>})
