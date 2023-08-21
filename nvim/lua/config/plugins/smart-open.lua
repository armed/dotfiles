return {
  "danielfalk/smart-open.nvim",
  branch = "0.2.x",
  config = function()
    require("telescope").load_extension("smart_open")
  end,
  keys = {
    {
      "<leader><space>",
      function()
        require("telescope").extensions.smart_open.smart_open({
          cwd_only = true,
        })
      end,
      desc = "Find files",
    },
  },
  dependencies = {
    "kkharji/sqlite.lua",
    "nvim-telescope/telescope-fzy-native.nvim",
  },
}
