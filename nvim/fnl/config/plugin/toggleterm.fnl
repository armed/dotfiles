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
      gt (T:new {:cmd "btm"
                 :direction "float"
                 :size 90
                 :hidden true})
      gt-toggle (fn [] (gt:toggle))]
    (wk.register {:t [gt-toggle "Bottom"]}
                 {:prefix :<leader>}))

