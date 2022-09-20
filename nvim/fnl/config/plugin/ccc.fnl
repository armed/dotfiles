(module config.plugin.ccc
  {autoload {core aniseed.core
             nvim aniseed.nvim
             wk which-key
             ccc ccc}})

(ccc.setup {:highlighter {:auto_enable true
                          :events ["BufEnter" "TextChanged" "TextChangedI"]}})
(wk.register {:C {:c [:<cmd>CccPick<cr> "Pick a color"]}}
             {:prefix :<leader>})
