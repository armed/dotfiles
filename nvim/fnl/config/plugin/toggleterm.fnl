(module config.plugin.toggleterm
  {autoload {core aniseed.core
             tt toggleterm
             terminal toggleterm.terminal
             wk which-key
             nvim aniseed.nvim}})

(tt.setup {:autochdir true})

(let [T terminal.Terminal
      git (T:new {:cmd "cd $NVIM_CWD && gitui"
                  :direction "float"
                  :size 80
                  :hidden true})
      git-toggle (fn [] (git:toggle))
      cmd (vim.api.nvim_create_user_command :CwdToggleGit git-toggle {})
      pen-cmd (fn []
                (set vim.env.NVIM_CWD (vim.fn.getcwd))
                (vim.cmd :CwdToggleGit))]
    (wk.register {:g [pen-cmd "Git"]}
                 {:prefix :<leader>}))

(let [T terminal.Terminal
      gt (T:new {:cmd "gotop"
                  :direction "float"
                  :size 90
                  :hidden true})
      gt-toggle (fn [] (gt:toggle))]
    (wk.register {:t [gt-toggle "Gotop"]}
                 {:prefix :<leader>}))

