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

  ; theme
  ;; :Shatur/neovim-ayu {:mod :ayu}
  :navarasu/onedark.nvim {:mod :onedark}
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

  ; file exploration
  ;; :preservim/nerdtree {:mod :nerdtree}
  ;; :Xuyuanp/nerdtree-git-plugin {}

  ; file searching
  :nvim-telescope/telescope.nvim {:requires [:nvim-telescope/telescope-ui-select.nvim
                                             :nvim-lua/popup.nvim
                                             :nvim-lua/plenary.nvim]
                                  :mod :telescope}

  ; commeting code
  :numToStr/Comment.nvim {:mod :comment}

  ; multicursor selector
  :mg979/vim-visual-multi {}
  ; text alignment
  :junegunn/vim-easy-align {:mod :easy-align}
  ; sexp
  :guns/vim-sexp {:mod :sexp}
  :tpope/vim-sexp-mappings-for-regular-people {}
  :kylechui/nvim-surround {:mod :surround}
  :tpope/vim-repeat {}
  ; repl tools
  :Olical/conjure {:branch :develop
                   :mod :conjure
                   :requires [:guns/vim-sexp
                              :tpope/vim-sexp-mappings-for-regular-people
                              :kylechui/nvim-surround]}

  ; git helper
  :lewis6991/gitsigns.nvim {:mod :gitsigns}

  ; which-key
  :folke/which-key.nvim {:mod :which-key}


  ; parsing system
  :nvim-treesitter/nvim-treesitter {:run ":TSUpdate"
                                    :mod :treesitter}

  ; snippets
  :L3MON4D3/LuaSnip {:requires [:saadparwaiz1/cmp_luasnip]}

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
                             :requires [:kyazdani42/nvim-web-devicons]}
  )
