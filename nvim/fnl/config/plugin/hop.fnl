(module config.plugin.hop
  {autoload {hop hop
             wk which-key}})

(hop.setup {:jump_on_sole_occurrence false
            :multi_windows true})

(wk.register
  {:<leader> {:s {:w [hop.hint_words "Hop words"]
                  :p [hop.hint_patterns "Hop pattern"]}}})

