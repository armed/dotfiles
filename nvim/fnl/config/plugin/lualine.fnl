(module config.plugin.lualine
  {autoload {lualine lualine
             navic nvim-navic
             core aniseed.core
             cp catppuccin.palettes}})

(local palette (cp.get_palette :mocha))
(local theme (require :lualine.themes.catppuccin))
(set theme.normal.c.bg palette.surface0)

(local config {:options {:icons_enabled true
                         :globalstatus true
                         :theme theme
                         ;; :component_sep arators {:left "" :right ""}
                         ;; :section_separators {:left "" :right ""}
                         :component_separators {:left "" :right ""}
                         :section_separators {:left "" :right ""}
                         :disabled_filetypes {}}
               :sections {:lualine_a [:mode]
                          :lualine_b [:diagnostics :diff]
                          :lualine_c []
                          :lualine_x []
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

(lualine.setup config)

