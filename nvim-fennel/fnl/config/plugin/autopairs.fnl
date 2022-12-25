(module config.plugin.autopairs
  {autoload {ap nvim-autopairs}})

(ap.setup
  {:disable_filetype [:clojure :TelescopePrompt :fennel]})
