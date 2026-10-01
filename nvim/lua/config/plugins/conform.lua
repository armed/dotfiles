return {
  "stevearc/conform.nvim",
  event = "VeryLazy",
  config = function()
    local conform = require("conform")

    local function js_formatter(bufnr)
      for _, name in ipairs({ "biome", "prettierd", "prettier" }) do
        if conform.get_formatter_info(name, bufnr).available then
          return { name }
        end
      end
      return {}
    end

    conform.setup({
      formatters_by_ft = {
        javascript = js_formatter,
        javascriptreact = js_formatter,
        typescript = js_formatter,
        typescriptreact = js_formatter,
        markdown = { "prettier", "injected" },
        java = { lsp_format = "first" },
        nim = { "nph" },
        lua = { "stylua" },
        just = { "just" },
        xml = { "xmllint" },
        toml = { "taplo" },
        rust = { "rustfmt", lsp_format = "fallback" },
        proto = { "clang-format" },
        sql = { "pg_format" },
        clojure = function(buf)
          local clients = vim.lsp.get_clients({ bufnr = buf })

          local supported = false
          for _, client in ipairs(clients) do
            if client:supports_method("textDocument/formatting") then
              supported = true
              break
            end
          end

          if supported then
            return {
              lsp_format = "first",
              "pruner_injected",
            }
          end

          return {
            "pruner",
          }
        end,
        json = { "jq" },
        ["*"] = function(bufnr)
          -- Markdown has its own injected formatter; Clojure's root formatter
          -- already handles injections, or explicitly selects pruner_injected.
          local ft = vim.bo[bufnr].filetype
          return (ft == "markdown" or ft == "clojure") and {}
            or { "pruner_injected" }
        end,
      },

      formatters = {
        prettier = {
          prepend_args = {
            "--no-semi",
            "--single-quote",
            "--no-bracket-spacing",
            "--print-width",
            "80",
            "--config-precedence",
            "prefer-file",
          },
        },
        pg_format = {
          args = { "--wrap-limit", "60", "--spaces", "2" },
        },
        taplo = {
          command = "taplo",
          stdin = true,
          args = {
            "fmt",
            "-",
          },
        },
        nph = {
          command = "nph",
          stdin = true,
          args = {
            "-",
          },
        },
        xmllint = {
          command = "xmllint",
        },
        zpr = {
          command = "zpr",
          args = {
            "{:pair {:justify? true :justify {:max-variance 20}} :map {:comma? false} :style [:justified :how-to-ns :respect-nl]}",
          },
        },
        just = {
          command = "just",
          args = {
            "--fmt",
            "--unstable",
            "-f",
            "$FILENAME",
          },
          stdin = false,
        },
        pruner_injected = require("config/common/pruner")({
          injected_only = true,
        }),
        pruner = require("config/common/pruner")(),
      },
    })

    local wk = require("which-key")

    wk.add({
      {
        "<leader>lf",
        function()
          conform.format()
        end,
        desc = "Format",
      },
    })
  end,
}
