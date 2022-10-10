(module config.plugin.ccc
  {autoload {wk which-key
             ccc ccc}})

(ccc.setup {:highlighter {:auto_enable true
                          :events ["BufEnter" "TextChanged" "TextChangedI"]}})
(wk.register {:C {:c [:<cmd>CccPick<cr> "Pick a color"]}}
             {:prefix :<leader>})
