return {
  "stevearc/conform.nvim",
  config = function()
    local conform = require("conform")

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
