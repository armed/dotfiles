(module config.plugin.lualine
  {autoload {core aniseed.core
             lualine lualine
             lsp config.plugin.lspconfig}})

(lualine.setup
  {:options {:theme :ayu}})

