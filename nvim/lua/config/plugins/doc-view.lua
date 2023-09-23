return {
  "amrbashir/nvim-docs-view",
  enabled = false,
  cmd = "DocsViewUpdate",
  commit = "601d7f6a2e399226a669fd2a73f7da77726cb32f",
  keys = {
    { "<leader>k", ":DocsViewUpdate<cr>", desc = "Show Docs View"}
  },
  opts = {
    position = "right",
    width = 80,
    update_mode = "manual",
  },
}
