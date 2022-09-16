(module config.plugin.lspsaga
  {autoload {nvim aniseed.nvim
             wk which-key
             saga lspsaga}})

(saga.setup
  {:rename_action_keys
   {:quit :<ESC>
    :exec :<CR>}})

