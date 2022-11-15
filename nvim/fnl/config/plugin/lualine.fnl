(module config.plugin.lualine
  {autoload {lualine lualine
             navic nvim-navic
             core aniseed.core
             cp catppuccin.palettes}})

(local palette (cp.get_palette :mocha))
(local theme (require :lualine.themes.catppuccin))
(set theme.normal.c.bg palette.surface0)

(fn get-lsp-client-names 
  []
  (let [clients (icollect [_ client (ipairs (vim.lsp.buf_get_clients))]
                  client.name)]
    (.. "[" (table.concat clients ",") "]")))

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
                          :lualine_c [[#(vim.fn.expand "%:.")]]
                          :lualine_x [[get-lsp-client-names] :progress]
                          :lualine_y [:filetype]
                          :lualine_z [:branch]}
               :tabline {}
               :extensions {}})

(fn ins-left [component]
  (table.insert config.sections.lualine_c component))
(fn ins-right [component]
  (table.insert config.sections.lualine_x component))

(lualine.setup config)

