(module config.mapping
  {autoload {nvim aniseed.nvim
             wk which-key}})

;generic mapping leaders configuration
;(nvim.set_keymap :n :<space> :<nop> {:noremap true})
(set nvim.g.mapleader " ")
(set nvim.g.maplocalleader ",")

;clear highlighting on enter in normal mode
(nvim.set_keymap :n :<esc> ":noh<CR><CR>" {:noremap true})
(nvim.set_keymap :i :jj "<esc>" {:noremap true})
(nvim.set_keymap :i :kj "<esc>" {:noremap true})
(nvim.set_keymap :i :jk "<esc>" {:noremap true})
(nvim.set_keymap :i :kk "<esc>" {:noremap true})

;duplicate currents panel in a new tab
(nvim.set_keymap :n :<C-w>T ":tab split<CR>" {:noremap true :silent true})

;escape from terminal normal mode
(nvim.set_keymap :t :<esc><esc> "<c-\\><c-n>" {:noremap true})

(nvim.set_keymap :n :<C-h> :<C-w>h {:noremap true})
(nvim.set_keymap :n :<C-j> :<C-w>j {:noremap true})
(nvim.set_keymap :n :<C-k> :<C-w>k {:noremap true})
(nvim.set_keymap :n :<C-l> :<C-w>l {:noremap true})

(nvim.set_keymap :n :<A-Up> "<cmd>resize -2<CR>" {:noremap true})
(nvim.set_keymap :n :<A-Down> "<cmd>resize +2<CR>" {:noremap true})
(nvim.set_keymap :n :<A-Right> "<cmd>vertical resize -2<CR>" {:noremap true})
(nvim.set_keymap :n :<A-Left> "<cmd>vertical resize +2<CR>" {:noremap true})

(wk.register {:q [":bd<cr>" "Close buffer"]}
             {:prefix :<leader>})
