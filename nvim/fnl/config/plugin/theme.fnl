(module config.plugin.nightfox
  {autoload {nvim aniseed.nvim
             wk which-key
             nvim-tree nvim-tree
             fox nightfox
             tokyo tokyonight}})

(fox.setup {:options {:dim_inactive true}
            :groups {:nightfox {:VertSplit {:fg "#a35400"}}
                     :dawnfox {:VertSplit {:fg "#696a6b"}}}})

(tokyo.setup {:dim_inactive true
              :on_colors (fn [colors] (set colors.border "#a35400"))
              :day_brightness 0.1
              :styles {:sidebars :transparent}})


(local tokyo {:light "tokyonight-day"
              :dark "tokyonight-night"})
(local fox {:light "dawnfox"
            :dark "nightfox"})

(local current-theme fox)
(nvim.ex.colorscheme (. current-theme nvim.o.bg))

(defn toggle-bg []
  (if (= "light" nvim.o.bg)
    (nvim.ex.colorscheme (. current-theme :dark))
    (nvim.ex.colorscheme (. current-theme :light)))
  (nvim-tree.toggle)
  (nvim-tree.toggle))

(wk.register {:s {:c [toggle-bg "Toggle theme"]}}
             {:prefix :<leader>})
