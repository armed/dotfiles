local home_dir = os.getenv("HOME")
local mise_installs = home_dir .. "/.local/share/mise/installs"
local mise_shims = home_dir .. "/.local/share/mise/shims"
local nim_version = "2.2.0"

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
  rust_analyzer = {
    cmd = { home_dir .. "/.cargo/bin/rust-analyzer" },
    settings = {
      ["rust-analyzer"] = {
        -- cargo = {
        --   features = "all",
        -- },
        notifications = {
          progress = true,
        },
        checkOnSave = {
          command = "clippy",
        },
        lens = {
          debug = { enable = true },
          enable = true,
          implementations = { enable = true },
          references = {
            adt = { enable = true },
            enumVariant = { enable = true },
            method = { enable = true },
            trait = { enable = true },
            run = { enable = true },
            updateTest = { enable = true },
          },
        },
      },
    },
  },
  cmake = {},
  biome = {},
  protols = {
    root_dir = function(fname)
      return vim.fs.dirname(
        vim.fs.find("protols.toml", { path = fname, upward = true })[1]
      )
    end,
  },
  nim_langserver = {
    single_file_support = true,
    filetypes = { "nim" },
    cmd = {
      home_dir .. "/.local/bin/nimlangserver",
    },
    message_level = 3,
    log_level = 3,
    settings = {
      single_file_support = true,
      nim = {
        -- nimsuggestPath = home_dir .. "/.local/bin/nimsuggest",
        nimsuggestPath = mise_installs
          .. "/nim/"
          .. nim_version
          .. "/bin/nimsuggest",
        -- notificationVerbosity = "none",
        autoRestart = true,
        autoCheckFile = true,
        autoCheckProject = true,
      },
    },
  },
  ts_ls = {},
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
  clangd = {
    filetypes = { "c", "cpp", "objc", "objcpp", "cuda" },
  },
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
