local servers = {
  clojure_lsp = {
    -- root_dir = function()
    --   return vim.fn.getcwd()
    -- end,
    init_options = {
      signatureHelp = true,
      codeLens = true,
    },
  },
  yamlls = {
    settings = {
      yaml = {
        schemas = {
          "https://json.schemastore.org/github-workflow.json",
          ".github/workflows/*",
        },
      },
    },
  },
  tsserver = {},
  jdtls = {
    settings = {
      single_file_support = true,
      java = {
        signatureHelp = { enabled = true },
        contentProvider = { preferred = "fernflower" },
      },
    },
  },
  jsonls = {},
  lua_ls = {
    settings = {
      Lua = {
        format = {
          enable = false,
          -- Put format options here
          -- NOTE: the value should be STRING!!
          defaultConfig = {
            indent_style = "space",
            indent_size = "2",
          },
        },
        runtime = {
          version = "LuaJIT",
        },
        diagnostics = {
          globals = { "vim" },
        },
        workspace = {
          checkThirdParty = false,
        },
        telemetry = { enable = false },
      },
    },
  },
}

local M = {
  "neovim/nvim-lspconfig",
  event = "BufReadPre",
  dependencies = {
    "jose-elias-alvarez/null-ls.nvim",
    {
      "williamboman/mason.nvim",
      opts = {
        ui = { border = "rounded" },
      },
    },
    {
      "folke/neodev.nvim",
      config = true,
    },
    "onsails/lspkind.nvim",
    "hrsh7th/cmp-nvim-lsp",
    "williamboman/mason-lspconfig.nvim",
    opts = {
      ensure_installed = vim.tbl_keys(servers),
    },
    {
      "j-hui/fidget.nvim",
      config = true,
    },
  },
}

function M.config()
  require("lspconfig.ui.windows").default_options.border = "rounded"
  local nls = require("null-ls")
  local mason_lspconfig = require("mason-lspconfig")
  local settings = require("config.plugins.lsp.settings")
  require("config.plugins.lsp.diagnostics").setup()

  local options = {
    handlers = settings.handlers,
    capabilities = settings.capabilities,
    flags = {
      debounce_text_changes = 150,
    },
  }

  nls.setup({
    save_after_format = true,
    sources = {
      nls.builtins.formatting.stylua,
      nls.builtins.formatting.just,
      nls.builtins.formatting.prettierd,
    },
  })

  mason_lspconfig.setup_handlers({
    function(server_name)
      local server_opts = servers[server_name] or {}
      local opts = vim.tbl_deep_extend("force", {}, options, server_opts)
      require("lspconfig")[server_name].setup(opts)
    end,
  })
end

return M
