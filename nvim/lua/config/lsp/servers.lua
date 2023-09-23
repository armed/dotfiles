return {
  clojure_lsp = {
    root_dir = require("config.lsp.utils").get_lsp_cwd,
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
        hint = { enable = true },
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
