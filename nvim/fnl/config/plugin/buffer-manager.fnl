(module config.plugin.buffer-manager
  {autoload {wk which-key
             buf buffer_manager
             buf-ui buffer_manager.ui}})

(buf.setup {:select_menu_item_commands {:v {:key :v :command :vsplit}
                                        :s {:key :s :command :split}}})

(wk.register {:f {:b [buf-ui.toggle_quick_menu "Buffers"]}})
