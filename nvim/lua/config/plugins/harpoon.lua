return {
  "ThePrimeagen/harpoon",
  keys = {
    { "<leader>b", desc = "Harpoon" }
  },
  config = function()
    local wk = require("which-key")
    local hm = require("harpoon.mark")
    local hui = require("harpoon.ui")

    wk.register({
      b = {
        a = { hm.add_file, "Mark File" },
        b = { hui.toggle_quick_menu, "Menu" },
        l = { hui.nav_next, "Next File" },
        h = { hui.nav_prev, "Prev File" },
      },
    }, { prefix = "<leader>" })
  end,
}
