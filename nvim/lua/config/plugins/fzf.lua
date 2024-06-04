return {
  "ibhagwan/fzf-lua",
  cmd = "FzfLua",
  keys = {
    { "<leader>f", desc = "FzfLua find" },
    { "<leader>r", desc = "FzfLua resume" },
  },
  dependencies = {
    "kyazdani42/nvim-web-devicons",
  },
  config = function()
    local wk = require("which-key")
    local fzf = require("fzf-lua")
    wk.register({
      r = { "<cmd>FzfLua resume<cr>", "FzfLua resume" },
      f = {
        f = { "<cmd>FzfLua files<cr>", "Files" },
        c = { "<cmd>FzfLua lgrep_curbuf<cr>", "In buffer" },
        g = { "<cmd>FzfLua live_grep<cr>", "Live grep" },
        b = { "<cmd>FzfLua buffers<cr>", "Buffers" },
        k = { "<cmd>FzfLua keymaps<cr>", "Keymaps" },
        r = { "<cmd>FzfLua oldfiles cwd_only=true<cr>", "Recent files" },
      },
    }, { prefix = "<leader>" })
    fzf.setup({
      winopts = {
        preview = {
          layout = "vertical",
          vertical = "up",
        },
      },
      keymap = {
        fzf = {
          ["ctrl-z"] = "abort",
          ["ctrl-u"] = "unix-line-discard",
          ["ctrl-f"] = "half-page-down",
          ["ctrl-b"] = "half-page-up",
          ["ctrl-a"] = "beginning-of-line",
          ["ctrl-e"] = "end-of-line",
          ["alt-a"] = "toggle-all",
          ["f3"] = "toggle-preview-wrap",
          ["f4"] = "toggle-preview",
          ["alt-j"] = "preview-page-down",
          ["alt-k"] = "preview-page-up",
          ["ctrl-q"] = "select-all+accept"
        },
      },
      fzf_opts = {
        ["--cycle"] = true,
        ["--layout"] = "default",
      },
    })
  end,
}
