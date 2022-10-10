(module config.plugin.toggleterm
  {autoload {core aniseed.core
             tt toggleterm
             terminal toggleterm.terminal
             wk which-key
             nvim aniseed.nvim}})

(tt.setup)

(let [T terminal.Terminal
      git (T:new {:cmd "gitui"
                      :direction "float"
                      :size 80
                      :hidden true})
      git-goggle (fn [] (git:toggle))]
    (wk.register {:g [git-goggle "Git"]}
                 {:prefix :<leader>}))

