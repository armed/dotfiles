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
   :anuvyklack/windows.nvim {:requires [:anuvyklack/middleclass]
                             :mod :windows}
   ; workspaces
   :natecraddock/workspaces.nvim {:mod :workspace}
   ; commands
   :kazhala/close-buffers.nvim {:mod :close-buffers}

   ; ui
   :b0o/incline.nvim {:mod :incline}
   ;; :folke/noice.nvim {:mod :noice :requires [:MunifTanjim/nui.nvim]}
   ;; :fgheng/winbar.nvim {:mod :winbar}
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
                                              :nvim-telescope/telescope-fzf-native.nvim]
                                   :mod :telescope}

   ; commeting code
   :numToStr/Comment.nvim {:mod :comment}

   ; sexp
   ;; :gpanders/nvim-parinfer {}
   :guns/vim-sexp {:mod :sexp}
   :radenling/vim-dispatch-neovim {}
   :tpope/vim-sexp-mappings-for-regular-people {}
   :tpope/vim-repeat {}
   :kylechui/nvim-surround {:mod :surround}
   :tpope/vim-dispatch {}

   ; repl tools
   ;; :PaterJason/cmp-conjure {}
   :Olical/conjure {:mod :conjure
                    :branch :develop
                    ;; :requires [:PaterJason/cmp-conjure]
                    }

   ; git
   :sindrets/diffview.nvim {:mod :diffview}
   :lewis6991/gitsigns.nvim {:mod :gitsigns}
   ;
   ; which-key
   :folke/which-key.nvim {:mod :which-key}

   ; parsing system
   :p00f/nvim-ts-rainbow {}
   :nvim-treesitter/nvim-treesitter-textobjects {}
   :nvim-treesitter/nvim-treesitter 
   {:run ":TSUpdate"
    ;; :event :BufReadPre
    :mod :treesitter
    :requires [:nvim-treesitter/nvim-treesitter-textobjects]}
   :nvim-treesitter/playground {:cmd :TSPlaygroundToggle}


   ; lsp
   :SmiteshP/nvim-navic {}
   :j-hui/fidget.nvim {}
   :onsails/lspkind.nvim {}
   :neovim/nvim-lspconfig {:mod :lspconfig 
                           :requires [:ibhagwan/fzf-lua
                                      :williamboman/mason-lspconfig.nvim
                                      :williamboman/mason.nvim]}
   ; luasnip
   :L3MON4D3/LuaSnip {:requires [:saadparwaiz1/cmp_luasnip
                                 :honza/vim-snippets]}

   ; autocomplete
   :hrsh7th/nvim-cmp {:requires [:hrsh7th/cmp-buffer
                                 :hrsh7th/cmp-path
                                 :saadparwaiz1/cmp_luasnip
                                 :hrsh7th/cmp-calc
                                 :hrsh7th/cmp-nvim-lsp
                                 :hrsh7th/cmp-nvim-lua
                                 :hrsh7th/cmp-vsnip]
                      :mod :cmp}

   ; color
   :uga-rosa/ccc.nvim {:mod :ccc :event :BufEnter}

   ; file-tree
   :nvim-neo-tree/neo-tree.nvim {:mod :neo-tree
                                 :branch "v2.x"
                                 :requires [:kyazdani42/nvim-web-devicons
                                            :s1n7ax/nvim-window-picker
                                            :nvim-lua/plenary.nvim
                                            :MunifTanjim/nui.nvim]}
   :kyazdani42/nvim-tree.lua {:mod :nvim-tree
                              :requires [:kyazdani42/nvim-web-devicons]}})


(util.use plugins)
