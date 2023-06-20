return {
  -- "julienvincent/nvim-paredit",
  dir = "~/Developer/neovim/nvim-paredit",
  ft = { "clojure" },
  enabled = true,
  config = function()
    local paredit = require("nvim-paredit")
    paredit.setup({
      filetypes = { "clojure" },
      cursor_behaviour = "auto",
      use_default_keys = false,
      keys = {
        ["<M-S-l>"] = { paredit.api.slurp_forwards, "Slurp forwards" },
        ["<M-S-h>"] = { paredit.api.slurp_backwards, "Slurp backwards" },

        ["<M-S-k>"] = { paredit.api.barf_forwards, "Barf forwards" },
        ["<M-S-j>"] = { paredit.api.barf_backwards, "Barf backwards" },

        ["<M-l>"] = { paredit.api.drag_element_forwards, "Drag element fowrad" },
        ["<M-h>"] = {
          paredit.api.drag_element_backwards,
          "Drag element backward",
        },

        [">f"] = { paredit.api.drag_form_forwards, "Drag form forward" },
        ["<f"] = { paredit.api.drag_form_backwards, "Drag form backward" },

        ["<localleader>o"] = { paredit.api.raise_form, "Raise form" },
        ["<localleader>O"] = { paredit.api.raise_element, "Raise element" },

        ["E"] = {
          paredit.api.move_to_next_element,
          "Jump to next element tail",
          repeatable = false,
        },
        ["B"] = {
          paredit.api.move_to_prev_element,
          "Jump to previous element head",
          repeatable = false,
        },
      },
    })
  end,
}
