(module config.plugin.close-buffers
  {autoload {cb close_buffers
             wk which-key}})

(cb.setup {})

(wk.register {:b {:name "Buffer"
                  :h [#(cb.delete {:type :hidden}) "Delete hidden"]
                  :o [#(cb.delete {:type :other}) "Delete other"]
                  :b [#(cb.delete {:type :this}) "Delete curreht"]}}
             {:prefix :<leader>})
