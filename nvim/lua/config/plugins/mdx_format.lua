return {
  "davidmh/mdx.nvim",
  ft = "mdx",
  init = function()
    vim.filetype.add({ extension = { mdx = "mdx" } })
    vim.treesitter.language.register("markdown", "mdx")
  end,
  dependencies = { "nvim-treesitter/nvim-treesitter" },
}
