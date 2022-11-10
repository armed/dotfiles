(module config.plugin.toggleterm
  {autoload {core aniseed.core
             tt toggleterm
             terminal toggleterm.terminal
             wk which-key
             nvim aniseed.nvim}})

(tt.setup {})

(let [T terminal.Terminal
      git (T:new {:cmd "cd $GITUI_CWD && gitui"
                  :direction "float"
                  :size 80
                  :hidden true})
      git-toggle (fn []
                   (let [file-path (vim.fn.expand "%:p:h")]
                     (set vim.env.GITUI_CWD (if (not= "" file-path)
                                              file-path
                                              (vim.fn.getcwd)))
                     (git:toggle)))]
    (wk.register {:g [git-toggle "Git"]}
                 {:prefix :<leader>}))

(let [T terminal.Terminal
      repl (T:new {:direction "float"
                   :size 80
                   :close_on_exit false
                   :hidden true})
      repl-toggle (fn [] 
                    (repl:toggle)
                    (vim.cmd :stopinsert!)
                    (nvim.buf_set_keymap 0 :t :jj :<esc><esc> {:silent true})
                    (nvim.buf_set_keymap 0 :n :q :<cmd>close<cr> {:silent true}))]

  (wk.register {:t [repl-toggle "Open terminal tab"]}
               {:prefix :<leader>}))
