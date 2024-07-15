return {
  "johmsalas/text-case.nvim",
  event = "VeryLazy",
  keys = {
    "ga",
    {
      "ga.",
      function ()
        vim.cmd("TextCaseOpenTelescopeLSPChange")
        vim.cmd("wa")
      end,
      mode = { "n", "x" },
      desc = "Telescope",
    },
  },
  config = function()
    require("textcase").setup({ default_keymappings_enabled = false })
    require("telescope").load_extension("textcase")
  end,
}
