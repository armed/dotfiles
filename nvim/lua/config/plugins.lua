-- list of plugins which does not require with lightweight configuration
return {
  {
    "dstein64/vim-startuptime",
    cmd = "StartupTime",
  },
  {
    "ThePrimeagen/harpoon",
    config = true,
  },
  {
    "kevinhwang91/nvim-bqf",
    event = "VeryLazy",
  },
  { "folke/todo-comments.nvim", event = "VeryLazy", config = true },
  {
    "mbbill/undotree",
    cmd = "UndotreeToggle",
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
    "kylechui/nvim-surround",
    event = "BufReadPost",
    config = true,
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
    "ggandor/leap.nvim",
    event = "VeryLazy",
    config = function()
      require("leap").add_default_mappings()
    end,
  },
  {
    "simrat39/symbols-outline.nvim",
    cmd = "SymbolsOutline",
    init = function()
      vim.keymap.set("n", "<leader>lo", ":SymbolsOutline<cr>", { desc = "Symbols Outline" })
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
    enabled = false,
    ft = { "clojure" },
    config = function()
      vim.g.parinfer_mode = "smart"
      vim.g.parinfer_force_balance = 1
    end,
  },
}
