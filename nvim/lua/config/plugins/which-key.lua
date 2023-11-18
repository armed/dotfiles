local M = {
  "folke/which-key.nvim",
  keys = {
    { "<leader>" },
    { "<localleader>" },
  },
}

function M.config()
  local wk = require("which-key")

  wk.setup({
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

  wk.register({
    u = {
      name = "Toggle",
      t = { ":TSContextToggle<cr>", "Treesitter Context" },
    },
    t = {
      name = "Terminal",
      v = { ":vsplit | term<cr>", "Vert Split Termial" },
      s = { ":split | term<cr>", "Split Terminal" },
    },
    e = { ":Neotree toggle<cr>", "Toggle Neo Tree" },
    E = { ":Neotree focus<cr>", "Focus Neo Tree" },
    s = { ":silent w<cr>", "Save buffer" },
    S = { ":silent wa<cr>", "Save all" },
    x = { save_all_quit, "Save and quit" },
    q = { "<c-w>q", "Close window" },
    L = { ":Lazy<cr>", "Lazy" },
    m = { ":Mason<cr>", "Mason" },
  }, { prefix = "<leader>" })
end

return M
