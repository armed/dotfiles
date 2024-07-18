return {
  "stevearc/conform.nvim",
  config = function()
    local conform = require("conform")
    local util = require("conform.util")

    local js_formatter = { "biome", "prettierd", "prettier" }

    conform.setup({
      formatters_by_ft = {
        javascript = { js_formatter },
        typescript = { js_formatter },
        typescriptreact = { js_formatter },

        nim = { "nimpretty" },
        lua = { "stylua" },
        just = { "just" },
        -- clojure = { "zpr" },
        -- zig = { "zig" },
      },

      formatters = {
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
        nimpretty = {
          command = "nimpretty",
          args = {
            "--indent:2",
            "$FILENAME",
          },
        },
        -- zig = {
        --   command = "zig",
        --   args = {
        --     "fmt",
        --     "$FILENAME",
        --   },
        -- },
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
      },
    })
  end,
}
