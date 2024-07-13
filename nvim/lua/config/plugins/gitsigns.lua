return {
  "lewis6991/gitsigns.nvim",
  event = "BufReadPost",
  opts = {
    current_line_blame_opts = {
      delay = 300,
    },
    signs = {
      add = { text = "▎" },
      change = { text = "▎" },
      delete = { text = "" },
      topdelete = { text = "" },
      changedelete = { text = "▎" },
      untracked = { text = "▎" },
    },
  },
  config = function(_, opts)
    local wk = require("which-key")
    local gs = require("gitsigns")
    wk.add({
      { "<leader>h", group = "Gitsigns" },
      { "<leader>hD", ":Gitsigns diffhis ~<cr>", desc = "Diff ~history" },
      { "<leader>hN", ":Gitsigns prev_hunk<cr><cr>", desc = "Prev hunk" },
      { "<leader>hR", ":Gitsigns reset_buffer<cr>", desc = "Reset buffer" },
      { "<leader>hS", ":Gitsigns stage_buffer<cr>", desc = "Stage buffer" },
      { "<leader>hb", ":Gitsigns blame_line<cr>", desc = "Blame line" },
      { "<leader>hd", ":Gitsigns diffthist<cr>", desc = "Diff history" },
      { "<leader>hn", ":Gitsigns next_hunk<cr><cr>", desc = "Next hunk" },
      { "<leader>hp", ":Gitsigns preview_hunk<cr>", desc = "Preview hunk" },
      { "<leader>hr", ":Gitsigns reset_hunk<CR>", desc = "Reset hunk" },
      { "<leader>hs", ":Gitsigns stage_hunk<cr>", desc = "Stage hunk" },
      { "<leader>ht", group = "Toggle" },
      {
        "<leader>htb",
        ":Gitsigns toggle_current_line_blame<cr>",
        desc = "Curent line blame",
      },
      { "<leader>htd", ":Gitsigns toggle_deleted<cr>", desc = "Deleted" },
      {
        "<leader>hu",
        ":Gitsigns undo_stage_hunk<cr>",
        desc = "Undo stage hunk",
      },
    })
    gs.setup(opts)
  end,
}
