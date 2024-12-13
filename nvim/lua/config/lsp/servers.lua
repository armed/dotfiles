local is_windows = package.config:sub(1, 1) == "\\"

local lua_ls = {
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
}

if is_windows then
  return {
    lua_ls = lua_ls,
    rust_analyzer = {
      cmd = {
        "rust-analyzer"
      }
    }
  }
else
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
      cmd = {
        mise_shims .. "/rust-analyzer"
      }
    },
    cmake = {},
    biome = {},
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
    lua_ls = lua_ls,
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
end
