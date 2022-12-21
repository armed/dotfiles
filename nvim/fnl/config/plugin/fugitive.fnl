(module config.plugin.fugitive
  {autoload {wk which-key}})

(fn push
  [force?]
  (vim.cmd (.. "Git push" (if force? " --force" ""))))

(fn pull
  []
  (vim.cmd "Git pull"))

(wk.register {:g {:name "Git"
                  :l [":Git log<cr>" "Log"]
                  :s [":Git<cr><C-w>L" "Status"]
                  :p [#(push false) "Push"]
                  :P [#(push true) "Force Push"]
                  :f [pull "Pull"]}}
             {:prefix :<leader>})
