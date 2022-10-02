(module config.plugin.nightfox
  {autoload {nvim aniseed.nvim
             wk which-key
             fox nightfox}})

(fox.init 
  {:dim_inactive true})

(defn toggle-bg 
  []
  (if (= "light" nvim.o.bg)
    (nvim.ex.colorscheme "nightfox")
    (nvim.ex.colorscheme "dawnfox")))


(wk.register {:s {:c [toggle-bg "Toggle theme"]}}
             {:prefix :<leader>})
