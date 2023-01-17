-- list of plugins which does not require with lightweight configuration
return {
  {
    'dstein64/vim-startuptime',
    cmd = 'StartupTime'
  },
  {
    'ThePrimeagen/harpoon',
    config = true
  },
  {
    'kevinhwang91/nvim-bqf',
    event = 'VeryLazy',
    dependencies = {
      { 'junegunn/fzf', build = 'make' }
    }
  },
  { 'folke/todo-comments.nvim', config = true },
  {
    'mbbill/undotree',
    cmd = 'UndotreeToggle'
  },
  {
    'numToStr/Comment.nvim',
    event = 'VeryLazy',
    config = true
  },
  'kyazdani42/nvim-web-devicons',
  'nvim-treesitter/nvim-treesitter-textobjects',
  {
    'nvim-treesitter/playground',
    cmd = 'TSPlaygroundToggle'
  },
  {
    'tpope/vim-fugitive',
    cmd = 'Git'
  },
  {
    'kylechui/nvim-surround',
    event = 'BufReadPost',
    config = true
  },
  {
    'lukas-reineke/indent-blankline.nvim',
    event = 'BufReadPost',
    config = {
      char = '┊'
    }
  },
  {
    'uga-rosa/ccc.nvim',
    event = 'VeryLazy'
  },
  {
    'guns/vim-sexp',

    ft = { 'clojure', 'lisp', 'fennel', 'scheme', 'janet' },

    init = function()
      vim.g.sexp_filetypes = 'clojure,scheme,lisp,fennel,janet'
    end,

    dependencies = {
      'radenling/vim-dispatch-neovim',
      'tpope/vim-sexp-mappings-for-regular-people',
      'tpope/vim-repeat'
    }
  },
  {
    'windwp/nvim-autopairs',
    event = 'VeryLazy',
    config = {
      disable_filetype = { 'clojure', 'TelescopePrompt', 'fennel' }
    }
  },
  {
    "ggandor/leap.nvim",
    event = "VeryLazy",
    config = function()
      require("leap").add_default_mappings()
    end
  },
  {
    "simrat39/symbols-outline.nvim",
    cmd = "SymbolsOutline",
    init = function()
      vim.keymap.set("n", "<leader>lo", ":SymbolsOutline<cr>", { desc = "Symbols Outline" })
    end,
    config = {
      keymaps = {
        focus_location = "<tab>"
      },
    }
  },
  {
    'iamcco/markdown-preview.nvim',
    ft = 'markdown',
    build = 'cd app && pnpm i',
    init = function()
      vim.g.mkdp_filetypes = { 'markdown' }
    end
  },
  {
    'uga-rosa/ccc.nvim',
    event = 'VeryLazy',
    config = {
      highlighter = {
        auto_enable = true,
        events = { 'BufReadPost', 'TextChanged', 'TextChangedI' },
      }
    }
  },
  {
    'smjonas/live-command.nvim',
    event = 'VeryLazy',
    config = {
      commands = {
        Norm = { cmd = "norm" }
      }
    }
  },
  {
    'nacro90/numb.nvim',
    event = 'VeryLazy',
    config = true
  },
}
