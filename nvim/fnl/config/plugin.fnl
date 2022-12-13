(module config.plugin
  {autoload {nvim aniseed.nvim
             a aniseed.core
             util config.util
             packer packer}})

(packer.init {:snapshot_path (.. (os.getenv "HOME") "/.config/nvim/packer.nvim")})

;plugins managed by packer
(def plugins
  {; plugin Manager
   :wbthomason/packer.nvim {:mod :packer}
   :Olical/aniseed {:branch :develop}
   :lewis6991/impatient.nvim {}

   :dstein64/vim-startuptime {}
   ; toggleterm
   :akinsho/toggleterm.nvim {:mod :toggleterm}
   ; themes
   :catppuccin/nvim {:mod :theme :as :catppuccin}

   ; dashboard
   :goolord/alpha-nvim {:require [:kyazdani42/nvim-web-devicons]
                        :mod :alpha}

   ; windows
   ;; :anuvyklack/windows.nvim {:requires [:anuvyklack/middleclass]
   ;;                           :mod :windows}
   :kevinhwang91/nvim-bqf {:mod :bqf
                           :requires [{1 :junegunn/fzf :run #(vim.fn.fzf#install)}]}
   ; workspaces
   :natecraddock/workspaces.nvim {:mod :workspace}

   ; ui
   :j-morano/buffer_manager.nvim {:mod :buffer-manager}
   :b0o/incline.nvim {:mod :incline}
   ; visual helpers
   :ggandor/leap.nvim {:mod :leap}
   :folke/todo-comments.nvim {:mod :todo}
   :lukas-reineke/indent-blankline.nvim {:mod :indent-blankline}

   ;; yaml
   :cuducos/yaml.nvim {:ft :yaml}
   ;; markdown
   :iamcco/markdown-preview.nvim {:ft :markdown}

   ;autopairs
   :windwp/nvim-autopairs {:mod :autopairs}
   ; icons
   :kyazdani42/nvim-web-devicons {}
   ;; fzf
   :ibhagwan/fzf-lua {}
   ;; autosave
   :nvim-zh/auto-save.nvim {:mod :autosave}
   ; status line
   :nvim-lualine/lualine.nvim {:mod :lualine
                               :require [:kyazdani42/nvim-web-devicons]}

   ; clip
   :AckslD/nvim-neoclip.lua 
   {:mod :neoclip
    :requires [:nvim-telescope/telescope.nvim
               {1 :kkharji/sqlite.lua :module :sqlite}]}

   ; file searching
   :nvim-telescope/telescope-fzf-native.nvim {:run :make}
   :nvim-telescope/telescope.nvim {:requires [:nvim-telescope/telescope-ui-select.nvim
                                              :nvim-lua/popup.nvim
                                              :nvim-telescope/telescope-file-browser.nvim
                                              :nvim-lua/plenary.nvim
                                              :LukasPietzschmann/telescope-tabs
                                              :nvim-telescope/telescope-fzf-native.nvim]
                                   :mod :telescope}

   ; commeting code
   :numToStr/Comment.nvim {:mod :comment}

   ; sexp
   :guns/vim-sexp {:mod :sexp}
   :radenling/vim-dispatch-neovim {}
   :tpope/vim-sexp-mappings-for-regular-people {}
   :tpope/vim-repeat {}
   :kylechui/nvim-surround {:mod :surround}
   :tpope/vim-dispatch {}

   ; repl tools
   :Olical/conjure {:mod :conjure
                    :branch :develop}

   ; undo
   :mbbill/undotree {:mod :undotree}
   ; git
   :lewis6991/gitsigns.nvim {:mod :gitsigns}
   ;
   ; which-key
   :folke/which-key.nvim {:mod :which-key}

   ; parsing system
   :nvim-treesitter/nvim-treesitter-textobjects {}
   :nvim-treesitter/nvim-treesitter {:run ":TSUpdate"
                                     :mod :treesitter}
   :nvim-treesitter/playground {:cmd :TSPlaygroundToggle}


   ; lsp
   ;; :dnlhc/glance.nvim {}
   :SmiteshP/nvim-navic {}
   :j-hui/fidget.nvim {}
   :onsails/lspkind.nvim {}
   :williamboman/mason-lspconfig.nvim {}
   :williamboman/mason.nvim {}
   :neovim/nvim-lspconfig {:mod :lspconfig}
   ;; :honza/vim-snippets {}
   :hrsh7th/cmp-buffer {}
   ;; :rafamadriz/friendly-snippets  {}
   :hrsh7th/cmp-path  {}
   ;; :saadparwaiz1/cmp_luasnip  {:ft [:fennel :lua]}
   :hrsh7th/cmp-cmdline {}
   :hrsh7th/cmp-calc  {}
   :hrsh7th/cmp-nvim-lsp  {}
   ;; :hrsh7th/cmp-nvim-lua  {}
   ;; :hrsh7th/cmp-vsnip  {}
   ;; :L3MON4D3/LuaSnip {:ft [:fennel :lua]}
   :hrsh7th/nvim-cmp {:mod :cmp}
   ;; :VonHeikemen/lsp-zero.nvim {:mod :lsp}

   ; color
   :uga-rosa/ccc.nvim {:mod :ccc}

   ; file-tree
   :nvim-neo-tree/neo-tree.nvim {:mod :neo-tree
                                 :branch "v2.x"
                                 :requires [:kyazdani42/nvim-web-devicons
                                            :s1n7ax/nvim-window-picker
                                            :nvim-lua/plenary.nvim
                                            :MunifTanjim/nui.nvim]}})

(util.use plugins)
