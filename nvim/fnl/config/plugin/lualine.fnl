(module config.plugin.lualine
  {autoload {lualine lualine
             navic nvim-navic}})

(local colors {:yellow "#ECBE7B"
               :cyan "#18aba6"
               :darkblue "#081633"
               :green "#98be65"
               :orange "#FF8800"
               :violet "#a9a1e1"
               :magenta "#c678dd"
               :blue "#51afef"
               :red "#ec5f67"})	

(local config {:options {:icons_enabled true
                         :globalstatus true
                         :theme "auto"
                         :component_separators {:left "" :right ""}
                         :section_separators {:left "" :right ""}
                         :disabled_filetypes {}}
               :sections {:lualine_a [:mode]
                          :lualine_b [:diagnostics :diff]
                          :lualine_c {}
                          :lualine_x {}
                          :lualine_y [:filetype]
                          :lualine_z [:branch]}
               :inactive_sections {:lualine_a {}
                                   :lualine_b {}
                                   :lualine_c [:filename]
                                   :lualine_x [:location]
                                   :lualine_y {}
                                   :lualine_z {}}
               :tabline {}
               :extensions {}})

(fn ins-left [component]
  (table.insert config.sections.lualine_c component))
(fn ins-right [component]
  (table.insert config.sections.lualine_x component))	

(ins-left {1 navic.get_location :cond navic.is_available})

(lualine.setup config)

