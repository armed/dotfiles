return {
  "stevearc/conform.nvim",
  event = "VeryLazy",
  config = function()
    local conform = require("conform")
    local util = require("conform.util")

    local js_formatter = { "biome", "prettierd", "prettier" }

    vim.api.nvim_create_user_command("Format", function(args)
      local range = nil
      if args.count ~= -1 then
        local end_line =
          vim.api.nvim_buf_get_lines(0, args.line2 - 1, args.line2, true)[1]
        range = {
          start = { args.line1, 0 },
          ["end"] = { args.line2, end_line:len() },
        }
      end
      conform.format({
        async = true,
        lsp_format = "fallback",
        range = range,
      })
    end, { range = true })

    conform.setup({
      formatters_by_ft = {
        javascript = js_formatter,
        typescript = js_formatter,
        typescriptreact = js_formatter,

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
        ["*"] = { "pruner_injected" },
      },

      formatters = {

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
        biome = {
          command = "biome",
          stdin = true,
          args = {
            "check",
            "--write",
            "--unsafe",
            "--stdin-file-path",
            "$FILENAME",
          },
          cwd = util.root_file({
            "biome.json",
            "package.json",
          }),
        },
        nph = {
          command = "nph",
          stdin = true,
          args = {
            "-",
            -- "$FILENAME",
          },
        },
        -- zig = {
        --   command = "zig",
        --   args = {
        --     "fmt",
        --     "$FILENAME",
        --   },
        -- },
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
  end,
}
