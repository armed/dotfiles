(module config.plugin.windows
  {autoload {w windows
             wk which-key}})

(w.setup {})

(wk.register {:w {:name "Window"
                  :m [::WindowsMaximize<cr> "Maximize"]
                  :v [::WindowsMaximizeVertically<cr> "Maximize vertically"]
                  :e [::WindowsEqualize<cr> "Equalize"]
                  :t [::WindowsToggleAutowidth<cr> "Toggle autowidth"]}}
             {:prefix :<leader>})
