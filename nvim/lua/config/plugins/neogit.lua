return {
  cmd = "Neogit",
  "TimUntersberger/neogit",
  opts = {
    disable_commit_confirmation = true,
    kind = "vsplit",
    signs = {
      section = { "", "" },
      item = { "", "" },
    },
  },
  keys = {
    { "<leader>g", desc = "Neogit" },
  },
  config = function(_, opts)
    require("neogit").setup(opts)
    local wk = require("which-key")
    wk.register({
      g = {
        g = { ":Neogit<cr>", "Status" },
        p = { ":Git push<cr>", "Push" },
        P = { ":Git push --force<cr>", "Force Push" },
        f = { ":Git pull<cr>", "Pull" },
        b = { ":Telescope git_branches<cr>", "Branches" },
      },
    }, { prefix = "<leader>" })
  end,
}
