(module nvim-paredit.bindings
  {autoload {core nvim-paredit.core
             insertion nvim-paredit.insertion
             wk which-key
             p nvim-paredit.position}})

(vim.keymap.set :n :<S-M-l> core.slurp-forward {:desc "Slurp forward"})
(vim.keymap.set :n :<S-M-k> core.barf-forward {:desc "Barf forward"})
(vim.keymap.set :n :<S-M-h> core.slurp-backward {:desc "Slurp backward"})
(vim.keymap.set :n :<S-M-j> core.barf-backward {:desc "Barf backward"})
(vim.keymap.set :n :<M-l> core.move-element-forward {:desc "Move element forward"})
(vim.keymap.set :n :<M-h> core.move-element-backward {:desc "Move element backward"})

(vim.keymap.set :n :<M-f> core.move-form-forward {:desc "Move enclosing form forward"})
(vim.keymap.set :n :<M-b> core.move-form-backward {:desc "Move enclosing form backward"})

(vim.keymap.set :n "<M-r>" core.raise-element {:desc "Raise element"})
(vim.keymap.set :n "<S-M-r>" core.raise-form {:desc "Raise enclosing form"})

(wk.register {:x {:name "De/Disexpress"
                  :f [core.disexpress-form "Disexpress enslosing form"]
                  :e [core.disexpress-element "Disexpress element"]
                  :F [core.dedisexpress-form "Dedisexpress enslosing form"]
                  :E [core.dedisexpress-element "Dedisexpress element"]}
              :d {:name "Delete sexp"
                  :f [core.elide-form "Delete form"]
                  :e [core.elide-element "Delete element"]}
              :w [core.wrap-in-form "Wrap in form"]
              :W [core.wrap-in-fn-call "Wrap in fn call"]
              :S [core.split "Split form"]}
             {:prefix :<localleader>})

(vim.keymap.set :i "(" (fn [] (insertion.insert-at-cursor "()" 1)))
(vim.keymap.set :i "[" (fn [] (insertion.insert-at-cursor "[]" 1)))
(vim.keymap.set :i "{" (fn [] (insertion.insert-at-cursor "{}" 1)))

(vim.keymap.set :i ")" (fn [] (if (= (insertion.next-char) ")")
                                (p.set-cursor-pos (p.pos+ (p.get-cursor-pos)
                                                          [0 1]))
                                (insertion.insert-at-cursor ")" 1))))
(vim.keymap.set :i "]" (fn [] (if (= (insertion.next-char) "]")
                                (p.set-cursor-pos (p.pos+ (p.get-cursor-pos)
                                                          [0 1]))
                                (insertion.insert-at-cursor "]" 1))))
(vim.keymap.set :i "}" (fn [] (if (= (insertion.next-char) "}")
                                (p.set-cursor-pos (p.pos+ (p.get-cursor-pos)
                                                          [0 1]))
                                (insertion.insert-at-cursor "}" 1))))

(vim.keymap.set :i "\"" (fn [] (let [nc (insertion.next-char)]
                                 (if (= nc "\"")
                                   (p.set-cursor-pos (p.pos+ (p.get-cursor-pos)
                                                             [0 1]))
                                   (insertion.insert-at-cursor "\"\"" 1)))))


