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

;; Example with cd:
;;
;; local lazygit = Terminal:new({
;;     cmd = 'cd $NVIM_CWD && lazygit',
;;     hidden = true,
;;     direction = 'float',
;;     on_open = float_handler,
;; })
;; api.nvim_create_user_command("UsToggleTermLazygit", function() lazygit:toggle() end, {})
;; Cmd:
;;
;; <cmd>lua vim.env.NVIM_CWD=vim.fn.getcwd(); vim.cmd("UsToggleTermLazygit")<cr>
