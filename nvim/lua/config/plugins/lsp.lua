local servers = require("config.lsp.servers")

local M = {
  "neovim/nvim-lspconfig",
  event = "BufReadPre",
  dependencies = {
    "mfussenegger/nvim-jdtls",
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
  },
}

function M.config()
  require("lspconfig.ui.windows").default_options.border = "rounded"
  require("config.lsp.diagnostics").setup()
  require("config.lsp.autocmds").setup()

  local nls = require("null-ls")
  local mason_lspconfig = require("mason-lspconfig")
  local settings = require("config.lsp.settings")

  mason_lspconfig.setup()

  local options = {
    handlers = settings.handlers,
    capabilities = settings.capabilities,
    -- on_attach = settings.on_attach,
    flags = {
      debounce_text_changes = 150,
    },
    before_init = function(params)
      if not params.workDoneToken then
        params.workDoneToken = "1"
      end
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

      vim.api.nvim_create_autocmd("FileType", {
        pattern = { "java" },
        desc = "Start and attach jdtls",
        callback = function()
          print("starting jdtls")
          jdtls.start_or_attach(config or {})
        end,
      })
    end,
  })
end

return M
