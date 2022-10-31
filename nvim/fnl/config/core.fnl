(module config.core
  {autoload {nvim aniseed.nvim
             util config.util
             str aniseed.string}})

;refresh changed content
(nvim.ex.autocmd "FocusGained,BufEnter" "*" ":checktime")
(set nvim.o.cmdheight 0) 

(nvim.create_autocmd 
  "TextYankPost"
  {:pattern "*"
   :callback #(vim.highlight.on_yank {:higroup :IncSearch
                                      :timeout 150})})

(nvim.create_autocmd
  "FileType"
  {:pattern [:help :man]
   :command "noremap <buffer> q <cmd>quit<cr>"
   :group my-group})

;don't wrap lines
(nvim.ex.set :nowrap)

(let [options
      {:termguicolors true
       :cursorline true
       :winfixheight true
       :winfixwidth false
       :equalalways true
       :encoding "utf-8"
       :scrolloff 5
       :conceallevel 2
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
       :relativenumber false
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
       :listchars (str.join "," ["tab:▶-" "trail:•" "extends:»" "precedes:«"])
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
       :signcolumn "yes:1"}]
  (each [option value (pairs options)]
    (util.set-global-option option value)))
