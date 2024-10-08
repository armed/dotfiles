return {
  "akinsho/flutter-tools.nvim",
  enabled = false,
  ft = { "dart" },
  dependencies = {
    "nvim-lua/plenary.nvim",
    "stevearc/dressing.nvim", -- optional for vim.ui.select
  },
  opts = {
    flutter_lookup_cmd = "asdf where flutter",
  },
  config = true,
}
