-- list of plugins which does not require long configuration
return {
  {
    'dstein64/vim-startuptime',
    cmd = 'StartupTime'
  },
  {
    'folke/which-key.nvim',
    config = {
      window = { border = 'double' },
      layout = { align = 'center' }
    }
  },
  {
    'ThePrimeagen/harpoon',
    config = true
  },
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
    config = true
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
  }
}
