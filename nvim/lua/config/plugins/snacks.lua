return {
  "folke/snacks.nvim",
  priority = 1000,
  lazy = false,
  ---@type snacks.Config
  opts = {
    styles = {
      input = {
        relative = "cursor",
        enter = false,
        title_pos = "left",
      },
    },
    input = {
      enabled = true,
    },
  },
}
