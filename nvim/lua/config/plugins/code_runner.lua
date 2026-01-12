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
          "cargo run --bin $fileNameWithoutExt",
        },
      },
      float = {
        border = "rounded",
      },
    })

    local wk = require("which-key")

    wk.add({
      { "<leader>r", "<cmd>RunCode<cr>", desc = "Run Code" },
      { "<leader>rt", "<cmd>RunFile term<cr>", desc = "Run Term" },
      { "<leader>rf", "<cmd>RunFile float<cr>", desc = "Run Float" },
      { "<leader>rc", "<cmd>RunClose<cr>", desc = "Run Close" },
    })
  end,
}
