(module config.plugin.incline
  {autoload {: incline
             icons config.icons
             navic nvim-navic
             nwd nvim-web-devicons}})

(incline.setup
  {:debounce_threshold {:falling 250 :rising 250}
   :window {:margin {:vertical 0 :horizontal 0}}
   :hide {:cursorline true}
   :highlight {:groups {:InclineNormal {:default true
                                        :group "@text.note"}
                        :InclineNormalNC {:default true
                                          :group "@text.note"}}}
   :render (fn [props]
             (let [bufname (vim.api.nvim_buf_get_name props.buf)
                   filename (vim.fn.fnamemodify bufname ":t")
                   render-spec {}
                   modified (if (vim.api.nvim_buf_get_option props.buf :modified)
                              icons.config.ui.BigCircle
                              "")
                   location (if (navic.is_available)
                              (.. (navic.get_location) " @ ")
                              "")
                   (filetype-icon color) (nwd.get_icon_color filename)
                   buffer [{1 filetype-icon :guifg :black}
                           [" "]
                           {1 location :gui :bold}
                           {1 (.. modified filename) :guifg :black :gui :bold}]]
               (each [_ buffer- (ipairs buffer)]
                 (table.insert render-spec buffer-))
               render-spec))})

