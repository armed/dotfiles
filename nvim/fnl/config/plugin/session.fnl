(module config.plugin.session
  {autoload {nvim aniseed.nvim
             telescope telescope
             nvim-tree nvim-tree
             wk which-key
             session persisted}})

(session.setup 
  {:autoload true
   :after_source (fn [] 
                   (nvim-tree.open)
                   (vim.lsp.stop_client (vim.lsp.get_active_clients)))
   :telescope 
   {:before_source #(vim.api.nvim_input "<ESC>:%bd<CR>")}})

(telescope.load_extension "persisted")


(local keys {:S {:name "Session"
                 :s [session.save "Save"]
                 :l ["<cmd>Telescope persisted<cr>" "Load"]}})
(wk.register keys {:prefix :<leader>})
