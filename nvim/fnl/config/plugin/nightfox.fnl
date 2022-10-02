(module config.plugin.nightfox
  {autoload {nvim aniseed.nvim
             wk which-key
             nvim-tree nvim-tree
             fox nightfox}})

(fox.init 
  {:dim_inactive true})

(defn toggle-bg 
  []
  (if (= "light" nvim.o.bg)
    (nvim.ex.colorscheme "nightfox")
    (nvim.ex.colorscheme "dawnfox"))
  (nvim-tree.toggle)
  (nvim-tree.toggle))


(wk.register {:s {:c [toggle-bg "Toggle theme"]}}
             {:prefix :<leader>})
