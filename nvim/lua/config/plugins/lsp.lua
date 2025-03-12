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
        -- no gleam in mason
        ensure_installed = vim.tbl_filter(function(key)
          return key ~= "gleam"
        end, vim.tbl_keys(servers)),
      },
    },
  },
}

local function deep_merge(t1, t2)
  for k, v in pairs(t2) do
    if (type(v) == "table") and (type(t1[k] or false) == "table") then
      deep_merge(t1[k], t2[k])
    else
      t1[k] = v
    end
  end
  return t1
end

local function merge_project_overrides(server_name, cmd_cwd, opts)
  if cmd_cwd ~= nil then
    local f = loadfile(cmd_cwd .. "/.lspconfig.lua")
    if f ~= nil then
      local cfg = f()

      if cfg ~= nil then
        if cfg[server_name] ~= nil then
          opts.settings = deep_merge(opts.settings, cfg[server_name].settings)
        end
      end
    elseif servers[server_name] ~= nil then
      opts.settings = servers[server_name].settings
    end
  end
  return opts
end

local function setup_server(server_name, options)
  local server_opts = servers[server_name] or {}
  local opts = vim.tbl_deep_extend("force", {}, options, server_opts)
  local server = require("lspconfig")[server_name]
  local abs_fname = vim.fn.expand("%:p")
  local cmd_cwd = coroutine.wrap(function()
    return server.document_config.default_config.root_dir(abs_fname)
  end)()
  if cmd_cwd then
    opts = merge_project_overrides(server_name, cmd_cwd, opts)
  end
  server.setup(opts)
end

function M.config()
  require("lspconfig.ui.windows").default_options.border = "rounded"
  require("config.lsp.diagnostics").setup()
  require("config.lsp.autocmds").setup()

  vim.lsp.log.set_level(vim.log.levels.ERROR)

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
    on_init = function(client)
      client.offset_encoding = "utf-8"
    end,
  }
  mason_lspconfig.setup_handlers({
    function(server_name)
      setup_server(server_name, options)
    end,

    ts_ls = require("config.lsp.tsserver").get_config(servers, options),

    jdtls = require("config.lsp.jtdls").get_config(servers, options),
  })
end

return M
