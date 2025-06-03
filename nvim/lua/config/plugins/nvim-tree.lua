return {
  "nvim-tree/nvim-tree.lua",
  version = "*",
  event = "VeryLazy",
  dependencies = {
    "nvim-tree/nvim-web-devicons",
  },
  config = function()
    require("nvim-tree").setup({
      update_focused_file = {
        enable = true,
      },
      notify = {
        absolute_path = false,
      },
      prefer_startup_root = false,
      sync_root_with_cwd = false,
      diagnostics = {
        enable = true,
        show_on_dirs = true,
        show_on_open_dirs = true,
        severity = {
          min = vim.diagnostic.severity.INFO,
          max = vim.diagnostic.severity.ERROR,
        },
        icons = {
          hint = "",
          info = "",
          warning = "",
          error = "",
        },
      },
      renderer = {
        highlight_git = "name",
        highlight_diagnostics = "all",
        icons = {
          show = {
            diagnostics = true,
          },
          diagnostics_placement = "signcolumn",
        },
      },
    })

    local wk = require("which-key")

    wk.add({
      { "<leader>e", group = "Neotree" },
      { "<leader>ee", "<cmd>NvimTreeToggle<cr>", desc = "Show and focus" },
      { "<leader>eq", "<cmd>NvimTreeClose<cr>", desc = "Close" },
    })
  end,
}
