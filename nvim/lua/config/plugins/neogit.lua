return {
  cmd = "Neogit",
  "NeogitOrg/neogit",
  opts = {
    disable_commit_confirmation = true,
    kind = "vsplit",
    log_view = {
      kind = "split"
    },
    signs = {
      section = { "", "" },
      item = { "", "" },
    },
  },
  keys = {
    { "<leader>g", desc = "Git" },
  },
  config = function(_, opts)
    require("neogit").setup(opts)
    local wk = require("which-key")
    wk.register({
      g = {
        name = "Git",
        g = { ":Neogit<cr>", "Status" },
        p = { ":Git push<cr>", "Push" },
        P = { ":Git push --force<cr>", "Force Push" },
        f = { ":Git pull<cr>", "Pull" },
        b = { ":Telescope git_branches<cr>", "Branches" },
      },
    }, { prefix = "<leader>" })
  end,
}
