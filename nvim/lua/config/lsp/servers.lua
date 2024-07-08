local home_dir = os.getenv("HOME")
local mise_installs = home_dir .. "/.local/share/mise/installs"
local mise_shims = home_dir .. "/.local/share/mise/shims"
local nim_version = "2.0.8"

return {
  clojure_lsp = {
    root_dir = require("config.lsp.utils").get_lsp_cwd,
    cmd = {
      mise_shims .. "/clojure-lsp",
      -- "--trace-level", "verbose"
    },
    single_file_support = true,
    init_options = {
      codeLens = true,
      signatureHelp = true,
      ["project-specs"] = {
        {
          ["project-path"] = "deps.edn",
          ["classpath-cmd"] = { "kmono", "cp" },
        },
      },
    },
    before_init = function(params)
      params.workDoneToken = "enable-progress"
    end,
  },
  biome = {},
  nim_langserver = {
    filetypes = { "nim" },
    cmd = {
      mise_installs .. "/nim/" .. nim_version .. "/nimble/bin/nimlangserver",
    },
    settings = {
      single_file_support = true,
      nim = {
        autoRestart = true,
        timeout = 30000,
        autoCheckFile = false,
      },
    },
  },
  gleam = {
    cmd = { "gleam", "lsp" },
  },
  zls = {},
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
  -- tsserver = {},
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
  volar = {},
  tailwindcss = {
    filetypes = {
      "aspnetcorerazor",
      "astro",
      "astro-markdown",
      "blade",
      "django-html",
      "htmldjango",
      "edge",
      "eelixir",
      "elixir",
      "ejs",
      "erb",
      "eruby",
      "gohtml",
      "haml",
      "handlebars",
      "hbs",
      "html",
      "html-eex",
      "heex",
      "jade",
      "leaf",
      "liquid",
      "markdown",
      "mdx",
      "mustache",
      "njk",
      "nunjucks",
      "php",
      "razor",
      "slim",
      "twig",
      "css",
      "less",
      "postcss",
      "sass",
      "scss",
      "stylus",
      "sugarss",
      "javascript",
      "javascriptreact",
      "reason",
      "rescript",
      "typescript",
      "typescriptreact",
      "vue",
      "svelte",
    },
  },
}
