(module config.plugin.bufferline
  {autoload {nvim aniseed.nvim
             bufferline bufferline}})

(local opts {:mode :buffers
             :themable true
             :numbers :none
             :buffer_close_icon ""
             :modified_icon "●"
             :close_icon ""
             :close_command "bdelete! %d"
             :left_mouse_command "buffer %d"
             :right_mouse_command "bdelete! %d"
             :middle_mouse_command nil
             :left_trunc_marker ""
             :right_trunc_marker ""
             :separator_style :thick
             :name_formatter nil
             :truncate_names true
             :tab_size 18
             :max_name_length 18
             :color_icons true
             :show_buffer_icons true
             :show_buffer_close_icons false
             :show_buffer_default_icon true
             :show_close_icon true
             :show_tab_indicators true
             :show_duplicate_prefix true
             :enforce_regular_tabs false
             :always_show_bufferline true
             :persist_buffer_sort true
             :max_prefix_length 15
             :sort_by :id
             :diagnostics false
             :diagnostics_indicator nil
             :diagnostics_update_in_insert true
             :offsets [{:filetype "NvimTree"
                        :text "File Explorer"
                        :highlight "Directory"
                        :separator false}]
             :groups {:items {} :options {:toggle_hidden_on_enter true}}
             :hover {:enabled false :reveal {} :delay 200}
             :debug {:logging false}})

(bufferline.setup {:options opts})
