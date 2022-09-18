(module config.plugin
  {autoload {nvim aniseed.nvim
             a aniseed.core
             util config.util
             packer packer}})

(defn safe-require-plugin-config [name]
  (let [(ok? val-or-err) (pcall require (.. :config.plugin. name))]
    (when (not ok?)
      (print (.. "config error: " val-or-err)))))

(defn- use [...]
  "Iterates through the arguments as pairs and calls packer's use function for
  each of them. Works around Fennel not liking mixed associative and sequential
  tables as well."
  (let [pkgs [...]]
    (packer.startup
      (fn [use]
        (for [i 1 (a.count pkgs) 2]
          (let [name (. pkgs i)
                opts (. pkgs (+ i 1))]
            (-?> (. opts :mod) (safe-require-plugin-config))
            (use (a.assoc opts 1 name)))))))
  nil)

;plugins managed by packer
(use
  ; plugin Manager
  :wbthomason/packer.nvim {}
  ; nvim config and plugins in Fennel
  :Olical/aniseed {:branch :develop}

  ;; git
  :TimUntersberger/neogit {:mod :neogit
                           :requires [:nvim-lua/plenary.nvim
                                      :sindrets/diffview.nvim]}
  ; toggleterm
  :akinsho/toggleterm.nvim {:mod :toggleterm}
  ; themes
  ;; :Shatur/neovim-ayu {:mod :ayu}
  :folke/tokyonight.nvim {}
  :navarasu/onedark.nvim {:mod :onedark}
  :rebelot/kanagawa.nvim {}

  ; icons
  :ryanoasis/vim-devicons {}
  :kyazdani42/nvim-web-devicons {}
  ;; fzf
  :ibhagwan/fzf-lua {:mod :fzf
                     :requires [:kyazdani42/nvim-web-devicons]}
  ;; autosave
  :pocco81/auto-save.nvim {:mod :autosave}
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
  :tpope/vim-abolish {}
  :tpope/vim-commentary {}
  :tpope/vim-dispatch {}
  :tpope/vim-eunuch {}
  :tpope/vim-repeat {}
  :tpope/vim-sleuth {}
  :tpope/vim-surround {}
  :tpope/vim-unimpaired {}
  :tpope/vim-vinegar {} 

  ; repl tools
  :Olical/conjure {:branch :develop
                   :mod :conjure
                   :requires [:guns/vim-sexp
                              :tpope/vim-sexp-mappings-for-regular-people
                              ;; :kylechui/nvim-surround
                              ]}

  ; git helper
  :lewis6991/gitsigns.nvim {:mod :gitsigns}

  ; which-key
  :folke/which-key.nvim {:mod :which-key}


  ; parsing system
  :nvim-treesitter/nvim-treesitter {:run ":TSUpdate"
                                    :mod :treesitter}

  ; lsp
  :neovim/nvim-lspconfig {:mod :lspconfig 
                          :requires [:ibhagwan/fzf-lua]}

  ; autocomplete
  :hrsh7th/nvim-cmp {:requires [:hrsh7th/cmp-buffer
                                :hrsh7th/cmp-path
                                :hrsh7th/cmp-calc
                                :hrsh7th/cmp-nvim-lsp
                                :hrsh7th/cmp-nvim-lua
                                :hrsh7th/cmp-vsnip
                                :PaterJason/cmp-conjure]
                     :mod :cmp}

  ; colorizer
  :norcalli/nvim-colorizer.lua {:mod :colorizer}

  ; hop
  :phaazon/hop.nvim {:mod :hop :branch "v2"}

  ; nvim-tree
  :kyazdani42/nvim-tree.lua {:mod :nvim-tree
                             :requires [:kyazdani42/nvim-web-devicons]})
