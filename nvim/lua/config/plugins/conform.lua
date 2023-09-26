return {
  "stevearc/conform.nvim",
  config = function()
    local conform = require("conform")

    local js_formatter = { "prettierd", "prettier" }

    conform.setup({
      formatters_by_ft = {
        javascript = { js_formatter },
        typescript = { js_formatter },
        typescriptreact = { js_formatter },

        lua = { "stylua" },
        just = { "just" },
        -- clojure = { "zpr" },
      },

      formatters = {
        zpr = {
          command = "zpr",
          args = { "{:pair {:justify? true :justify {:max-variance 20}} :map {:comma? false} :style [:justified :how-to-ns :respect-nl]}" },
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
