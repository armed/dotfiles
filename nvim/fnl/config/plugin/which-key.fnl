(module config.plugin.which-key
  {autoload {wk which-key}})

(wk.setup {:window {:border :double }
           :layout {:align :center}})
