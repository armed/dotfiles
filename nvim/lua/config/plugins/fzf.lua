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
          ["ctrl-q"] = "select-all+accept",
        },
      },
      fzf_opts = {
        ["--cycle"] = true,
        ["--layout"] = "default",
      },
    })

    wk.add({
      { "<leader>fb", "<cmd>FzfLua buffers<cr>", desc = "Buffers" },
      { "<leader>fc", "<cmd>FzfLua lgrep_curbuf<cr>", desc = "In buffer" },
      { "<leader>ff", "<cmd>FzfLua files<cr>", desc = "Files" },
      { "<leader>fg", "<cmd>FzfLua grep_project<cr>", desc = "Grep project" },
      { "<leader>fk", "<cmd>FzfLua keymaps<cr>", desc = "Keymaps" },
      -- {
      --   "<leader>fr",
      --   "<cmd>FzfLua oldfiles cwd_only=true<cr>",
      --   desc = "Recent files",
      -- },
      { "<leader>fr", "<cmd>FzfLua resume<cr>", desc = "FzfLua resume" },
      {
        "<leader>fv",
        "<cmd>FzfLua grep_visual<cr>",
        desc = "Grep selection",
        mode = "v",
      },
    })
  end,
}
