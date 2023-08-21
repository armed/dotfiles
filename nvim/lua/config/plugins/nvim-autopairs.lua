return {
  "windwp/nvim-autopairs",
  event = "InsertEnter",
  opts = {
    disable_filetype = {
      "TelescopePrompt",
    },
    check_ts = true,
    enable_check_bracket_line = false,
  },
  config = function(_, opts)
    local cond = require("nvim-autopairs.conds")
    local ap = require("nvim-autopairs")
    ap.setup(opts)

    ap.get_rules("'")[1].not_filetypes =
      { "scheme", "lisp", "clojure", "fennel" }
    ap.get_rules("'")[1]:with_pair(cond.not_after_text("["))
  end,
}
