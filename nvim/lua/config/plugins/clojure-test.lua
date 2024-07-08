return {
  event = "VeryLazy",
  "julienvincent/clojure-test.nvim",
  config = function()
    require("clojure-test").setup({
      use_default_keys = true
    })
  end,
  dependencies = {
    { "nvim-neotest/nvim-nio" },
    { "MunifTanjim/nui.nvim" },
  },
}
