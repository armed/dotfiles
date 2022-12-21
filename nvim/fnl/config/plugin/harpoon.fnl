(module config.plugin.harpoon
  {autoload {wk which-key
             h harpoon
             hm harpoon.mark
             hui harpoon.ui
             hterm harpoon.term}})

(h.setup {})

(wk.register {:b {:name :Harpoon
                  :a [hm.add_file "Mark File"]
                  :b [hui.toggle_quick_menu "Menu"]
                  :l [hui.nav_next "Next file"]
                  :h [hui.nav_prev "Prev file"]}}
             {:prefix :<leader>})
