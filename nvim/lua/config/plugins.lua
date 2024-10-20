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
  "kyazdani42/nvim-web-devicons",
  "nvim-treesitter/nvim-treesitter-textobjects",
  {
    "tpope/vim-fugitive",
    cmd = "Git",
  },
  {
    "lukas-reineke/indent-blankline.nvim",
    event = "BufReadPost",
    main = "ibl",
    opts = {
      indent = {
        char = "┊",
      },
      scope = {
        enabled = false
      },
      exclude = {
        buftypes = { "qf", "lazy", "lspinfo", "mason" },
      },
    },
  },
  {
    "hedyhli/outline.nvim",
    cmd = "Outline",
    init = function()
      vim.keymap.set(
        "n",
        "<leader>lo",
        "<cmd>Outline<cr>",
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
    cmd = { "MarkdownPreviewToggle", "MarkdownPreview", "MarkdownPreviewStop" },
    build = "cd app && pnpm install",
    init = function()
      vim.g.mkdp_filetypes = { "markdown" }
    end,
    ft = { "markdown" },
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
    "andweeb/presence.nvim",
    event = "VeryLazy",
    config = true,
  },
}
