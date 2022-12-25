local handlers = require 'config.plugins.lsp.handlers'

local servers = {
  clojure_lsp = {
    root_dir = vim.fn.getcwd,
    init_options = {
      signatureHelp = true,
      codeLens = true
    },
    flags = { debounce_text_changes = 150 },
    -- cmd = {'/usr/local/bin/clojure-lsp'}
  },
  yamlls = {
    settings = {
      yaml = {
        schemas = {
          'https://json.schemastore.org/github-workflow.json',
          '.github/workflows/*'
        }
      }
    }
  },
  tsserver = {},
  jdtls = {},
  jsonls = {},
  sumneko_lua = {
    Lua = {
      workspace = { checkThirdParty = false },
      telemetry = { enable = false },
    },
  }
}

local M = {
  'neovim/nvim-lspconfig',
  event = 'BufReadPre',
  dependencies = {
    {
      'williamboman/mason.nvim',
      config = {
        ui = { border = 'rounded' }
      }
    },
    'onsails/lspkind.nvim',
    'hrsh7th/cmp-nvim-lsp',
    'williamboman/mason-lspconfig.nvim',
    {
      'j-hui/fidget.nvim',
      config = { window = { blend = 0 } }
    },
  },
}

function M.config()
  local mason_lspconfig = require 'mason-lspconfig'

  mason_lspconfig.setup {
    ensure_installed = vim.tbl_keys(servers),
  }

  local cmplsp = require('cmp_nvim_lsp')
  local capabilities = cmplsp.default_capabilities(
    vim.lsp.protocol.make_client_capabilities())

  mason_lspconfig.setup_handlers {
    function(server_name)
      require('lspconfig')[server_name].setup {
        handlers = handlers.handlers,
        capabilities = capabilities,
        on_attach = handlers.on_attach,
        settings = servers[server_name],
      }
    end,
  }
end

return M

