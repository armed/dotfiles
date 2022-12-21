(module config.plugin.nightfox
  {autoload {nvim aniseed.nvim
             wk which-key
             catppuccin catppuccin}})

(catppuccin.setup {:flavour :mocha
                   :integrations {:fidget true
                                  :navic {:enabled true}}
                   :background {:light :latte
                                :dark :mocha}
                   :dim_inactive {:enabled true}
                   :color_overrides
                   {:mocha {:surface2 "#737487"}}
                   :custom_highlights 
                   (fn [colors]
                     {:VertSplit {:fg colors.peach}})})

(nvim.ex.colorscheme :catppuccin)

