(module config.plugin.lualine
  {autoload {core aniseed.core
             lualine lualine
             lsp config.plugin.lspconfig}})

(lualine.setup {:options {:globalstatus true
                          :component_separators {:left "" :right ""}
                          :section_separators {:left "" :right ""}
                          :theme "auto"}})
