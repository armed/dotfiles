local servers = require("config.lsp.servers")

local M = {
  "neovim/nvim-lspconfig",
  event = "BufReadPre",
  dependencies = {
    "mfussenegger/nvim-jdtls",
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
    -- before_init = function(params)
    --   if not params.workDoneToken then
    --     params.workDoneToken = "1"
    --   end
    -- end,
  }
  mason_lspconfig.setup_handlers({
    function(server_name)
      local server_opts = servers[server_name] or {}
      local opts = vim.tbl_deep_extend("force", {}, options, server_opts)
      require("lspconfig")[server_name].setup(opts)
    end,

    ["tsserver"] = require("config.lsp.tsserver").get_config(servers, options),

    ["jdtls"] = require("config.lsp.jtdls").get_config(servers, options),
  })
end

return M
