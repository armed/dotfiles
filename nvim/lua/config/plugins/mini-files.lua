return {
  "echasnovski/mini.files",
  version = false,
  config = true,
  keys = {
    {
      "<leader>o",
      function()
        require("mini.files").open()
      end,
      desc = "Mini Files"
    },
  },
}
