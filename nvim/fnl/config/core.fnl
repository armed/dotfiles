(module config.core
  {autoload {nvim aniseed.nvim
             util config.util
             str aniseed.string}})

;refresh changed content
(nvim.ex.autocmd "FocusGained,BufEnter" "*" ":checktime")
(set nvim.o.cursorline true)
(set nvim.o.cursorcolumn false)
(set nvim.g.winfixheight true) 
(local hl-yank (nvim.create_augroup :hl-yank {}))
(nvim.create_autocmd 
  "TextYankPost"
  {:pattern "*"
   :callback #(vim.highlight.on_yank {:higroup :IncSearch
                                      :timeout 150})
   :group hl-yank})

;; (nvim.ex.colorscheme "")
;don't wrap lines
(nvim.ex.set :nowrap)

(let [options
      {:encoding "utf-8"
       :scrolloff 5
       ;; :spelllang "en_us"
       :backspace "2"
       :colorcolumn "80"
       :errorbells true
       :backup false
       :swapfile false
       :showmode false
       ;; hl autogroup
       :updatetime 200
       :timeoutlen 200
       ;show line numbers
       :number true
       :relativenumber true
       ;show line and column number
       :ruler true
       ;settings needed for compe autocompletion
       :completeopt "menuone,noselect"
       ;turn on the wild menu, auto complete for commands in command line
       :wildmenu true
       :wildignore "*/tmp/*,*.so,*.swp,*.zip"
       ;case insensitive search
       :ignorecase true
       ;smart search case
       :smartcase true
       ;shared clipboard with linux
       :clipboard "unnamedplus"
       ;show invisible characters
       :list true
       :listchars (str.join "," ["tab:▶-" "trail:•" "extends:»" "precedes:«" "eol:¬"])
       ;tabs is space
       :expandtab true
       ;tab/indent size
       :tabstop 2
       :shiftwidth 2
       :softtabstop 2
       ;persistent undo
       :undofile true
       ;open new horizontal panes on down pane
       :splitbelow true
       ;open new vertical panes on right pane
       :splitright true
       ;enable highlighting search
       :hlsearch true
       ;makes signcolumn always one column with signs and linenumber
       :signcolumn "auto"}]
  (each [option value (pairs options)]
    (util.set-global-option option value)))

