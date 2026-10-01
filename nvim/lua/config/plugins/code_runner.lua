return {
  "CRAG666/code_runner.nvim",
  cmd = { "RunCode", "RunFile", "RunClose" },
  keys = {
    { "<leader>r", "<cmd>RunCode<cr>", desc = "Run Code" },
    { "<leader>rt", "<cmd>RunFile term<cr>", desc = "Run Term" },
    { "<leader>rf", "<cmd>RunFile float<cr>", desc = "Run Float" },
    { "<leader>rc", "<cmd>RunClose<cr>", desc = "Run Close" },
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
  end,
}
