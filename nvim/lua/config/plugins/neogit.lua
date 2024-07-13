return {
  "NeogitOrg/neogit",
  cmd = "Neogit",
  opts = {
    disable_commit_confirmation = true,
    kind = "vsplit",
    log_view = {
      kind = "split",
    },
    commit_editor = {
      kind = "split",
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
    wk.add({
      { "<leader>g", group = "Git" },
      { "<leader>gP", ":Git push --force<cr>", desc = "Force Push" },
      { "<leader>gb", ":Telescope git_branches<cr>", desc = "Branches" },
      { "<leader>gf", ":Git pull<cr>", desc = "Pull" },
      { "<leader>gg", ":Neogit<cr>", desc = "Status" },
      { "<leader>gp", ":Git push<cr>", desc = "Push" },
    })
  end,
}
