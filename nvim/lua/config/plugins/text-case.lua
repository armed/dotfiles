return {
  "johmsalas/text-case.nvim",
  dependencies = { "nvim-telescope/telescope.nvim" },
  keys = {
    "ga",
    {
      "ga.",
      "<cmd>TextCaseOpenTelescopeLSPChange<cr>",
      mode = { "n", "x" },
      desc = "Telescope",
    },
  },
  config = function()
    require("textcase").setup({ default_keymappings_enabled = false })
    require("telescope").load_extension("textcase")
  end,
}
