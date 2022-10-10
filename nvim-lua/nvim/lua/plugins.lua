local M = {}

function M.setup()
  -- Indicate first time installation
  local packer_bootstrap = false

  -- packer.nvim configuration
  local conf = {
    profile = {
      enable = true,
      threshold = 0, -- the amount in ms that a plugins load time must be over for it to be included in the profile
    },

    display = {
      open_fn = function()
        return require("packer.util").float { border = "rounded" }
      end,
    },
  }

  -- Check if packer.nvim is installed
  -- Run PackerCompile if there are changes in this file
  local function packer_init()
    local fn = vim.fn
    local install_path = fn.stdpath "data" .. "/site/pack/packer/start/packer.nvim"
    if fn.empty(fn.glob(install_path)) > 0 then
      packer_bootstrap = fn.system {
        "git",
        "clone",
        "--depth",
        "1",
        "https://github.com/wbthomason/packer.nvim",
        install_path,
      }
      vim.cmd [[packadd packer.nvim]]
    end

    -- Run PackerCompile if there are changes in this file
    -- vim.cmd "autocmd BufWritePost plugins.lua source <afile> | PackerCompile"
    local packer_grp = vim.api.nvim_create_augroup("packer_user_config", { clear = true })
    vim.api.nvim_create_autocmd(
      { "BufWritePost" },
      { pattern = "plugins.lua", command = "source <afile> | PackerCompile", group = packer_grp }
    )
  end

  -- Plugins
  local function plugins(use)
    use { "wbthomason/packer.nvim" }

    -- Performance
    use { "lewis6991/impatient.nvim" }

    -- Load only when require
    use { "nvim-lua/plenary.nvim", module = "plenary" }

    use {
      "kylechui/nvim-surround",
      config = function()
        require("nvim-surround").setup()
      end
    }

    -- Clojure
    use { "guns/vim-sexp", ft = { "fennel", "lua", "clojure" } }
    use {
      "tpope/vim-sexp-mappings-for-regular-people",
      ft = { "fennel", "lua", "clojure" }
    }
    use { "tpope/vim-repeat", ft = { "fennel", "lua", "clojure" } }
    use {
      "Olical/conjure",
      branch = "develop",
      ft = { "fennel", "lua", "clojure" },
      config = function()
        vim.g.sexp_filetypes = "clojure,scheme,lisp,timl,fennel,janet"
        require("config.conjure").setup()
      end,
      requires = {
        "radenling/vim-dispatch-neovim",
      }
    }

    -- Keymaps
    use {
      "folke/which-key.nvim",
      event = "VimEnter",
      config = function()
        require("which-key").setup {
          window = { border = "double" },
          layout = { align = "center" }
        }
      end
    }

    use {
      "kyazdani42/nvim-tree.lua",
      module = "nvim-tree",
      cmd = { "NvimTreeToggle" },
      wants = { "nvim-web-devicons", "which-key.nvim" },
      requires = { "kyazdani42/nvim-web-devicons" },
      config = function()
        require("config.nvim-tree").setup()
      end
    }

    -- Session
    -- use {
    --   "Shatur/neovim-session-manager",
    --   wants = { "nvim-tree.lua" },
    --   config = function()
    --     require("config.session").setup()
    --   end,
    --   disabled = true
    -- }
    -- Auto save
    use {
      "nvim-zh/auto-save.nvim",
      config = function()
      end
    }

    use {
      "lukas-reineke/indent-blankline.nvim",
      opt = true,
      event = "BufReadPre",
      config = function()
        require("indent_blankline").setup()
      end
    }

    -- Telescope
    use {
      "nvim-telescope/telescope.nvim",
      wants = {
        "telescope-fzf-native.nvim",
        "telescope-ui-select.nvim",
        "popup.nvim",
        "plenary.nvim",
        "telescope-zoxide"
      },
      requires = {
        "nvim-telescope/telescope-ui-select.nvim",
        "nvim-lua/popup.nvim",
        "jvgrootveld/telescope-zoxide",
        "nvim-lua/plenary.nvim",
        { "nvim-telescope/telescope-fzf-native.nvim", run = "make" }
      },
      config = function()
        require("config.telescope").setup()
      end,
      opt = true,
      cmd = { "Telescope" },
    }

    -- Themes
    use {
      "EdenEast/nightfox.nvim",
      wants = { "lualine.nvim" },
      config = function()
        require("config.theme").setup()
      end
    }

    -- LSP
    use {
      "neovim/nvim-lspconfig",
      opt = true,
      event = { "BufReadPre" },
      wants = {
        "mason.nvim",
        "mason-lspconfig.nvim",
        "cmp-nvim-lsp",
        "telescope.nvim"
      },
      requires = {
        "williamboman/mason.nvim",
        "williamboman/mason-lspconfig.nvim",
      },
      config = function()
        require("config.lsp").setup()
      end
    }

    -- cmp
    use {
      "hrsh7th/nvim-cmp",
      event = "InsertEnter",
      opt = true,
      config = function()
        require("config.cmp").setup()
      end,
      requires = {
        "hrsh7th/cmp-buffer",
        "hrsh7th/cmp-path",
        "hrsh7th/cmp-calc",
        "hrsh7th/cmp-nvim-lsp",
        "hrsh7th/cmp-nvim-lua",
        "hrsh7th/cmp-vsnip"
      }
    }

    use { "kyazdani42/nvim-web-devicons", module = "nvim-web-devicons" }

    use {
      "nvim-lualine/lualine.nvim",
      opt = true,
      event = "BufReadPre",
      after = "nvim-treesitter",
      requires = { "kyazdani42/nvim-web-devicons" },
      config = function()
        require("lualine").setup({
          options = {
            globalstatus = true,
            component_separators = { left = "", right = "" },
            section_separators = { left = "", right = "" },
            theme = "auto"
          }
        })
      end
    }

    use {
      "numToStr/Comment.nvim",
      config = function()
        require("Comment").setup()
      end
    }


    -- Treesitter
    use {
      "nvim-treesitter/nvim-treesitter",
      opt = true,
      event = "BufReadPre",
      run = ":TSUpdate",
      requires = {
        "nvim-treesitter/nvim-treesitter-textobjects",
        "nvim-treesitter/playground"
      },
      config = function()
        require("config.treesitter").setup()
      end
    }

    -- Startup time
    use { "dstein64/vim-startuptime", cmd = "StartupTime" }

    -- Bootstrap Neovim
    if packer_bootstrap then
      print "Neovim restart is required after installation!"
      require("packer").sync()
    end
  end

  -- Init and start packer
  packer_init()
  local packer = require "packer"

  -- Performance
  pcall(require, "impatient")
  -- pcall(require, "packer_compiled")

  packer.init(conf)
  packer.startup(plugins)
end

return M
