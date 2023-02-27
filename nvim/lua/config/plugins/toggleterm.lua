return {
  "akinsho/toggleterm.nvim",
  event = "VeryLazy",
  config = function()
    local wk = require("which-key")
    local t = require("toggleterm.terminal")

    local repl = t.Terminal:new({
      direction = "float",
      size = 80,
      close_on_exit = false,
      hidden = true,
    })
    local function repl_term()
      repl:toggle()
      vim.keymap.set("n", "q", ":close<cr>", { silent = true, buffer = 0 })
    end

    wk.register({
      t = {
        t = { repl_term, "Toggle Term" },
      },
    }, { prefix = "<leader>" })
  end,
}
