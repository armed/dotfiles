(module config.plugin
  {autoload {nvim aniseed.nvim
             a aniseed.core
             util config.util
             packer packer}})

(packer.init {:snapshot_path (.. (os.getenv "HOME") "/.config/nvim/packer.nvim")})

;plugins managed by packer
(def plugins
  {; plugin Manager
   :wbthomason/packer.nvim {}
   :lewis6991/impatient.nvim {}
   :dstein64/vim-startuptime {}
   ; nvim config and plugins in Fennel
   :Olical/aniseed {:branch :develop}
   ;; session
   :Shatur/neovim-session-manager {:mod :session}
   ; toggleterm
   :akinsho/toggleterm.nvim {:mod :toggleterm}
   ; themes
   :folke/tokyonight.nvim {}
   :EdenEast/nightfox.nvim {:mod :theme}

   ; dressing
   :stevearc/dressing.nvim {}

   ;; markdown
   :iamcco/markdown-preview.nvim {:ft :markdown}

   ; icons
   :ryanoasis/vim-devicons {}
   :kyazdani42/nvim-web-devicons {}
   ;; fzf
   :ibhagwan/fzf-lua {:mod :fzf
                      :requires [:kyazdani42/nvim-web-devicons]}
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
                                              :jvgrootveld/telescope-zoxide
                                              :nvim-lua/plenary.nvim
                                              :nvim-telescope/telescope-fzf-native.nvim]
                                   :mod :telescope}

   ; commeting code
   :numToStr/Comment.nvim {:mod :comment}

   ; multicursor selector
   ;; :mg979/vim-visual-multi {}
   ; text alignment
   ;; :junegunn/vim-easy-align {:mod :easy-align}
   ; sexp
   :guns/vim-sexp {:mod :sexp}
   :radenling/vim-dispatch-neovim {}
   :tpope/vim-sexp-mappings-for-regular-people {}
   :kylechui/nvim-surround {:mod :surround}
   ;; :tpope/vim-abolish {}
   ;; :tpope/vim-commentary {}
   :tpope/vim-dispatch {:opt true 
                        :cmd [:Dispatch :Make :Focus :Start]}

   ; repl tools
   :Olical/conjure {:mod :conjure
                    :requires [[:guns/vim-sexp]
                               [:tpope/vim-sexp-mappings-for-regular-people]
                               [:PaterJason/cmp-conjure]
                               ;; :kylechui/nvim-surround
                               ]}

   ; git
   :TimUntersberger/neogit {:requires [[:nvim-lua/plenary.nvim]
                                       [:sindrets/diffview.nvim]]
                            :mod :neogit}
   :lewis6991/gitsigns.nvim {:mod :gitsigns}
   ;
   ; which-key
   :folke/which-key.nvim {:mod :which-key}

   ; parsing system
   :nvim-treesitter/nvim-treesitter 
   {:run ":TSUpdate"
    :mod :treesitter
    :requires [:nvim-treesitter/nvim-treesitter-textobjects]}
   :nvim-treesitter/playground {}

   ; lsp
   :neovim/nvim-lspconfig {:mod :lspconfig 
                           :requires [:ibhagwan/fzf-lua
                                      :williamboman/mason-lspconfig.nvim
                                      :williamboman/mason.nvim]}
   ; luasnip
   :L3MON4D3/LuaSnip {:requires [:saadparwaiz1/cmp_luasnip]}

   ; autocomplete
   :hrsh7th/nvim-cmp {:requires [[:hrsh7th/cmp-buffer]
                                 [:hrsh7th/cmp-path]
                                 [:hrsh7th/cmp-calc]
                                 [:hrsh7th/cmp-nvim-lsp]
                                 [:hrsh7th/cmp-nvim-lua]
                                 [:hrsh7th/cmp-vsnip]]
                      :mod :cmp}

   ; color
   ;; :uga-rosa/ccc.nvim {:mod :ccc :event :BufEnter :opt true}

   ; hop
   :phaazon/hop.nvim {:mod :hop :branch "v2"}

   ; nvim-tree
   :kyazdani42/nvim-tree.lua {:mod :nvim-tree
                              :requires [:kyazdani42/nvim-web-devicons]}})

(util.use plugins)

