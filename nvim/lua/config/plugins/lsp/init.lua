local servers = {
  clojure_lsp = {
    root_dir = function()
      return vim.fn.getcwd()
    end,
    init_options = {
      signatureHelp = true,
      codeLens = true
    }
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
  commit = '3e2cc7061957292850cc386d9146f55458ae9fe3',
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
    'nvim-telescope/telescope.nvim',
    {
      'williamboman/mason-lspconfig.nvim',
      config = {
        ensure_installed = vim.tbl_keys(servers),
      }
    },
    { 'j-hui/fidget.nvim', config = true },
  },
}

function M.config()
  require('lspconfig.ui.windows').default_options.border = 'rounded'
  local mason_lspconfig = require 'mason-lspconfig'
  local settings = require 'config.plugins.lsp.settings'
  require 'config.plugins.lsp.diagnostics'.setup()

  local options = {
    handlers = settings.handlers,
    on_attach = settings.on_attach,
    capabilities = settings.capabilities,
    flags = {
      debounce_text_changes = 150,
    },
  }

  mason_lspconfig.setup_handlers {
    function(server_name)
      local server_opts = servers[server_name] or {}
      local opts = vim.tbl_deep_extend('force', {}, options, server_opts)
      require("lspconfig")[server_name].setup(opts)
    end
  }
end

return M
