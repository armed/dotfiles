(module config.plugin.toggleterm
  {autoload {core aniseed.core
             tt toggleterm
             terminal toggleterm.terminal
             wk which-key
             nvim aniseed.nvim}})

(tt.setup)

(let [T terminal.Terminal
        lazygit (T:new {:cmd "gitui"
                        :direction "float"
                        :size 80
                        :hidden true})
        lazygit_toggle (fn [] (lazygit:toggle))]
    (wk.register {:g [lazygit_toggle "Git"]}
                 {:prefix :<leader>}))
