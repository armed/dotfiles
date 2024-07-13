local M = {
  "folke/which-key.nvim",
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
    window = { border = "double" },
    layout = { align = "center" },
    plugins = {
      spelling = {
        enabled = true,
        suggestions = 20,
      },
    },
    hidden = {
      "<silent>",
      "<cmd>",
      "<Cmd>",
      "<CR>",
      "call",
      "lua",
      "^:",
      "^ ",
      "<Plug>",
      "^%(",
      "%)$",
    },
  })

  local function save_all_quit()
    vim.cmd("silent wa")
    vim.cmd("silent qa!")
  end

  wk.add({
    { "<leader>E", ":Neotree focus<cr>", desc = "Focus Neo Tree" },
    { "<leader>L", ":Lazy<cr>", desc = "Lazy" },
    { "<leader>S", ":silent wa<cr>", desc = "Save all" },
    { "<leader>e", ":Neotree toggle<cr>", desc = "Toggle Neo Tree" },
    { "<leader>m", ":Mason<cr>", desc = "Mason" },
    { "<leader>q", "<c-w>q", desc = "Close window" },
    { "<leader>s", ":silent w<cr>", desc = "Save buffer" },
    { "<leader>t", group = "Terminal" },
    { "<leader>ts", ":split | term<cr>", desc = "Split Terminal" },
    { "<leader>tv", ":vsplit | term<cr>", desc = "Vert Split Termial" },
    { "<leader>u", group = "Toggle" },
    { "<leader>ut", ":TSContextToggle<cr>", desc = "Treesitter Context" },
    { "<leader>x", save_all_quit, desc = "Save and quit" },
  })
end

return M
