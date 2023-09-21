local servers = {
  clojure_lsp = {
    root_dir = require("config.plugins.lsp.utils").get_lsp_cwd,
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
  clangd = {},
  graphql = {
    root_dir = function()
      return vim.fn.getcwd()
    end,
  },
}

local M = {
  "neovim/nvim-lspconfig",
  event = "BufReadPre",
  dependencies = {
    "jose-elias-alvarez/null-ls.nvim",
    {
      "folke/neodev.nvim",
      config = true,
    },
    "onsails/lspkind.nvim",
    "hrsh7th/cmp-nvim-lsp",
    {
      "williamboman/mason-lspconfig.nvim",
      dependencies = {
        "williamboman/mason.nvim",
        opts = {
          ui = { border = "rounded" },
        },
      },
      opts = {
        ensure_installed = vim.tbl_keys(servers),
      },
    },
    {
      "j-hui/fidget.nvim",
      enabled = false,
      tag = "legacy",
      config = true,
    },
  },
}

function M.config()
  require("lspconfig.ui.windows").default_options.border = "rounded"
  require("config.plugins.lsp.diagnostics").setup()
  require("config.plugins.lsp.autocmds").setup()

  local nls = require("null-ls")
  local mason_lspconfig = require("mason-lspconfig")
  local settings = require("config.plugins.lsp.settings")

  mason_lspconfig.setup()

  local options = {
    handlers = settings.handlers,
    capabilities = settings.capabilities,
    -- on_attach = settings.on_attach,
    flags = {
      debounce_text_changes = 150,
    },
    before_init = function(params)
      params.workDoneToken = "1"
    end,
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

    ["tsserver"] = function()
      require("typescript-tools").setup({})
    end,

    ["jdtls"] = function()
      local jdtls = require("jdtls")
      local utils = require("config.common.utils")

      local registry = require("mason-registry")
      local package = registry.get_package("jdtls")
      local jdtls_install_dir = package:get_install_path()

      local config_dir = "config_mac"
      if vim.fn.has("linux") == 1 then
        config_dir = "config_linux"
      end

      local home_dir = os.getenv("HOME")
      local project_id = vim.fn.sha256(vim.fn.getcwd())
      local data_dir = home_dir
        .. "/.local/share/nvim/jdtls/projects/"
        .. project_id

      local launcher = utils.find_file_by_glob(
        jdtls_install_dir .. "/plugins",
        "org.eclipse.equinox.launcher_*"
      )

      local cmd = {
        "java",

        "-Declipse.application=org.eclipse.jdt.ls.core.id1",
        "-Dosgi.bundles.defaultStartLevel=4",
        "-Declipse.product=org.eclipse.jdt.ls.core.product",
        "-Dlog.protocol=true",
        "-Dlog.level=ALL",
        "-Xmx1g",
        "--add-modules=ALL-SYSTEM",
        "--add-opens",
        "java.base/java.util=ALL-UNNAMED",
        "--add-opens",
        "java.base/java.lang=ALL-UNNAMED",

        "-jar",
        launcher,

        "-configuration",
        jdtls_install_dir .. "/" .. config_dir,

        "-data",
        data_dir,
      }

      local extendedClientCapabilities =
        require("jdtls").extendedClientCapabilities
      local config = vim.tbl_deep_extend(
        "force",
        {},
        options,
        servers["jdtls"] or {},
        {
          cmd = cmd,
          init_options = {
            extendedClientCapabilities = vim.tbl_deep_extend(
              "force",
              {},
              extendedClientCapabilities,
              {
                resolveAdditionalTextEditsSupport = true,
              }
            ),
          },
        }
      )

      -- TODO:
      --
      -- Add a script which analyses the clojure project deps.edn and compiles a list of external dependencies.
      -- These dependencies can be found on disk (in ~/.m2) and used to construct references.
      --
      -- See:
      -- https://github.com/mfussenegger/nvim-jdtls?tab=readme-ov-file#language-server-doesnt-find-classes-that-should-be-there

      vim.api.nvim_create_autocmd("FileType", {
        pattern = { "java" },
        desc = "Start and attach jdtls",
        callback = function()
          jdtls.start_or_attach(config)
        end,
      })
    end,
  })
end

return M
