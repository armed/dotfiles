local M = {
  "folke/which-key.nvim",
  evant = "VeryLazy",
  keys = {
    { "<leader>" },
    { "<localleader>" },
  },
  dependencies = {
    "kyazdani42/nvim-web-devicons",
    { "echasnovski/mini.icons", version = false },
  },
}

function M.config()
  local wk = require("which-key")

  wk.setup({
    preset = "helix",
    win = { border = "double" },
    layout = { align = "center" },
    plugins = {
      spelling = {
        enabled = true,
        suggestions = 20,
      },
    },
  })

  local function save_all_quit()
    vim.cmd("silent wa")
    vim.cmd("silent qa!")
  end

  wk.add({
    { "<leader>L", "<cmd>Lazy<cr>", desc = "Lazy" },
    { "<leader>S", "<cmd>silent wa<cr>", desc = "Save all" },
    { "<leader>m", "<cmd>Mason<cr>", desc = "Mason" },
    { "<leader>q", "<c-w>q", desc = "Close window" },
    { "<leader>s", "<cmd>silent w<cr>", desc = "Save buffer" },
    { "<leader>t", group = "Terminal" },
    { "<leader>ts", "<cmd>split | term<cr>", desc = "Split Terminal" },
    { "<leader>tv", "<cmd>vsplit | term<cr>", desc = "Vert Split Termial" },
    { "<leader>u", group = "Toggle" },
    { "<leader>ut", "<cmd>TSContextToggle<cr>", desc = "Treesitter Context" },
    { "<leader>x", save_all_quit, desc = "Save and quit" },
  })
end

return M
