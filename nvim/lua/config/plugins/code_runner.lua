return {
  "CRAG666/code_runner.nvim",
  event = "VeryLazy",
  keys = {
    { "<leader>r", "<cmd>RunCode<cr>", desc = "Run Code" },
  },
  config = function()
    require("code_runner").setup({
      filetype = {
        rust = {
          "cargo test --test $fileNameWithoutExt"
        }
      },
      float = {
        border = "rounded",
      },
    })

    local wk = require("which-key")

    wk.add({
      { "<leader>r", "<cmd>RunCode<cr>", desc = "Run Code" },
      { "<leader>rt", "<cmd>RunFile term<cr>", desc = "Run Test Term" },
      { "<leader>rf", "<cmd>RunFile float<cr>", desc = "Run Test Float" },
      { "<leader>rc", "<cmd>RunClose<cr>", desc = "Run Close" },
    })
  end,
}
