return {
  "CRAG666/code_runner.nvim",
  event = "VeryLazy",
  keys = {
    { "<leader>r", "<cmd>RunCode<cr>", desc = "Run Code" },
  },
  config = function()
    require("code_runner").setup({
      filetype = {
        nim = {
          "nim r $dir/$fileName",
        },
      },
      float = {
        border = "rounded",
      },
    })

    local wk = require("which-key")

    wk.add({
      { "<leader>r", "<cmd>RunCode<cr>", desc = "Run Code" },
      { "<leader>rff", "<cmd>RunFile float<cr>", desc = "Run File Float" },
      { "<leader>rft", "<cmd>RunFile term<cr>", desc = "Run File in Term" },
      { "<leader>rp", "<cmd>RunProject<cr>", desc = "Run Project" },
      { "<leader>rc", "<cmd>RunClose<cr>", desc = "Run Close" },
    })
  end,
}
