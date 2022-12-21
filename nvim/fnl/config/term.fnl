(module config.plugin.toggleterm
  {autoload {core aniseed.core
             wk which-key
             nvim aniseed.nvim}})

(wk.register {:t {:name "Terminal"
                  :v [":vsplit | term<cr>" "Vert Split Terminal"]
                  :s [":split | term<cr>" "Split Terminal"]}}
             {:prefix :<leader>})

(fn set-terminal-keymaps []
  (let [opts {:buffer  0}
        vks vim.keymap.set]
    (vks :t :<esc><esc> :<C-\><C-n> opts)
    (vks :t :<C-h> "<Cmd>wincmd h<CR>" opts)
    (vks :t :<C-j> "<Cmd>wincmd j<CR>" opts)
    (vks :t :<C-k> "<Cmd>wincmd k<CR>" opts)
    (vks :t :<C-l> "<Cmd>wincmd l<CR>" opts)))

(nvim.create_autocmd
  "TermOpen"
  {:pattern "term://*"
   :callback set-terminal-keymaps})

