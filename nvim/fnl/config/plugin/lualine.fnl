(module config.plugin.lualine
  {autoload {core aniseed.core
             lualine lualine
             lsp config.plugin.lspconfig}})

(local colors {:bg "#030015"
               :fg "#bbc2cf"
               :yellow "#ECBE7B"
               :cyan "#008080"
               :darkblue "#081633"
               :green "#98be65"
               :orange "#FF8800"
               :violet "#a9a1e1"
               :magenta "#c678dd"
               :blue "#51afef"
               :red "#ec5f67"})	

(local conditions
  {:buffer_not_empty #(not= (vim.fn.empty (vim.fn.expand "%:t")) 1)
   :hide_in_width #(> (vim.fn.winwidth 0) 80)
   :check_git_workspace #(let [filepath (vim.fn.expand "%:p:h")
                               gitdir (vim.fn.finddir :.git (.. filepath ";"))]
                           (and (and gitdir (> (length gitdir) 0))
                                (< (length gitdir) (length filepath))))})

(local config
  {:options {:component_separators ""
             :section_separators ""
             :globalstatus true
             :theme {:normal {:c {:fg colors.fg :bg colors.bg}}
                     :inactive {:c {:fg colors.fg :bg colors.bg}}}}
   :sections {:lualine_a {}
              :lualine_b {}
              :lualine_y {}
              :lualine_z {}
              :lualine_c {}
              :lualine_x {}}
   :inactive_sections {:lualine_a {}
                       :lualine_b {}
                       :lualine_y {}
                       :lualine_z {}
                       :lualine_c {}
                       :lualine_x {}}})	

(fn ins-left [component]
  (table.insert config.sections.lualine_c component))
(fn ins-right [component]
  (table.insert config.sections.lualine_x component))	

(ins-left {1 (fn [] "▊")
           :color {:fg colors.blue}
           :padding {:left 0 :right 1}})	

(ins-left {1 (fn [] "")
           :color (fn []
                    (local mode-color
                           {:n colors.red
                            :i colors.green
                            :v colors.blue
                            "\022" colors.blue
                            :V colors.blue
                            :c colors.magenta
                            :no colors.red
                            :s colors.orange
                            :S colors.orange
                            "\019" colors.orange
                            :ic colors.yellow
                            :R colors.violet
                            :Rv colors.violet
                            :cv colors.red
                            :ce colors.red
                            :r colors.cyan
                            :rm colors.cyan
                            :r? colors.cyan
                            :! colors.red
                            :t colors.red})
                    {:fg (. mode-color (vim.fn.mode))})
           :padding {:right 1}})	

(ins-left {1 :filesize :cond conditions.buffer_not_empty})
(ins-left {1 :filename
           :cond conditions.buffer_not_empty
           :color {:fg colors.magenta :gui :bold}})
(ins-left [:location])
(ins-left {1 :progress :color {:fg colors.fg :gui :bold}})
(ins-left {1 :diagnostics
           :sources [:nvim_diagnostic]
           :symbols {:error " " :warn " " :info " "}
           :diagnostics_color {:color_error {:fg colors.red}
                               :color_warn {:fg colors.yellow}
                               :color_info {:fg colors.cyan}}})	
(ins-left [(fn [] "%=")])
(ins-left {1 (fn []
               (let [msg "No Active Lsp"
                     buf-ft (vim.api.nvim_buf_get_option 0 :filetype)
                     clients (vim.lsp.get_active_clients)]
                 (when (= (next clients) nil)
                   (lua "return msg"))
                 (each [_ client (ipairs clients)]
                   (local filetypes client.config.filetypes)
                   (when (and filetypes
                              (not= (vim.fn.index filetypes buf-ft) (- 1)))
                     (let [___antifnl_rtn_1___ client.name]
                       (lua "return ___antifnl_rtn_1___"))))
                 msg))
           :icon " LSP:"
           :color {:fg "#ffffff" :gui :bold}})
(ins-right {1 "o:encoding"
            :fmt string.upper
            :cond conditions.hide_in_width
            :color {:fg colors.green :gui :bold}})	
(ins-right {1 :fileformat
            :fmt string.upper
            :icons_enabled false
            :color {:fg colors.green :gui :bold}})
(ins-right {1 :branch :icon "" :color {:fg colors.violet :gui :bold}})
(ins-right {1 :diff
            :symbols {:added " " :modified "柳 " :removed " "}
            :diff_color {:added {:fg colors.green}
                         :modified {:fg colors.orange}
                         :removed {:fg colors.red}}
            :cond conditions.hide_in_width})
(ins-right {1 (fn [] "▊")
            :color {:fg colors.blue}
            :padding {:left 1}})	

;; (lualine.setup {:options {:theme :onedark}})
(lualine.setup {:options {:globalstatus true
                          :component_separators {:left "" :right ""}
                          :section_separators {:left "" :right ""}
                          :theme "auto"}})
