-- list of plugins which does not require with lightweight configuration
return {
  {
    "dstein64/vim-startuptime",
    cmd = "StartupTime",
  },
  {
    "kevinhwang91/nvim-bqf",
    event = "VeryLazy",
  },
  { "folke/todo-comments.nvim", event = "VeryLazy", config = true },
  {
    "mbbill/undotree",
    keys = {
      { "<leader>U", ":UndotreeToggle<cr>", desc = "Undo Tree" },
    },
  },
  {
    "numToStr/Comment.nvim",
    event = "VeryLazy",
    config = true,
  },
  "kyazdani42/nvim-web-devicons",
  "nvim-treesitter/nvim-treesitter-textobjects",
  {
    "nvim-treesitter/playground",
    cmd = "TSPlaygroundToggle",
  },
  {
    "tpope/vim-fugitive",
    cmd = "Git",
  },
  {
    "lukas-reineke/indent-blankline.nvim",
    enabled = false,
    event = "BufReadPost",
    opts = {
      char = "┊",
      buftype_exclude = { "qf", "lazy", "lspinfo", "mason" },
    },
  },
  {
    "uga-rosa/ccc.nvim",
    event = "VeryLazy",
  },
  {
    "windwp/nvim-autopairs",
    event = "VeryLazy",
    opts = {
      disable_filetype = {
        "clojure",
        "TelescopePrompt",
        "fennel",
      },
    },
  },
  {
    "simrat39/symbols-outline.nvim",
    cmd = "SymbolsOutline",
    init = function()
      vim.keymap.set(
        "n",
        "<leader>lo",
        ":SymbolsOutline<cr>",
        { desc = "Symbols Outline" }
      )
    end,
    opts = {
      keymaps = {
        focus_location = "<tab>",
      },
    },
  },
  {
    "iamcco/markdown-preview.nvim",
    ft = "markdown",
    build = "cd app && pnpm i",
    init = function()
      vim.g.mkdp_filetypes = { "markdown" }
    end,
  },
  {
    "uga-rosa/ccc.nvim",
    event = "VeryLazy",
    opts = {
      highlighter = {
        auto_enable = true,
        events = { "BufReadPost", "TextChanged", "TextChangedI" },
      },
    },
  },
  {
    "smjonas/live-command.nvim",
    enabled = false,
    event = "VeryLazy",
    opts = {
      commands = {
        Norm = { cmd = "norm" },
      },
    },
  },
  {
    "NoahTheDuke/vim-just",
    ft = "just",
  },
  {
    "eraserhd/parinfer-rust",
    build = "cargo build --release",
    name = "parinfer",
    enabled = false,
    ft = { "clojure" },
    config = function()
      vim.g.parinfer_mode = "paren"
    end,
  },
  {
    "folke/zen-mode.nvim",
    cmd = "ZenMode",
    config = true,
    keys = {
      { "<leader><leader>", ":ZenMode<cr>", desc = "Enter Zen Mode" },
    },
  },
  {
    "andweeb/presence.nvim",
    event = "VeryLazy",
    config = true,
  },
}
