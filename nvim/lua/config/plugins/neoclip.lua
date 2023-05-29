return {
  "AckslD/nvim-neoclip.lua",
  enabled = true,
  keys = {
    { "<leader>n", ":Telescope neoclip<cr>", desc = "Nepclip" },
  },
  dependencies = {
    "kkharji/sqlite.lua"
  },
  config = function()
    local neoclip = require("neoclip")
    neoclip.setup({
      enable_persistent_history = true,
    })
    require("telescope").load_extension("neoclip")
  end,
}
