return {
  {
    "ldelossa/litee.nvim",
    event = "VeryLazy",
    opts = {
      notify = { enabled = false },
      tree = {
        icon_set = "codicons",
        indent_guides = false,
      },
      panel = {
        orientation = "right",
        panel_size = 80,
      },
    },
    config = function(_, opts)
      require("litee.lib").setup(opts)
    end,
  },
  {
    "ldelossa/litee-calltree.nvim",
    dependencies = "ldelossa/litee.nvim",
    keys = {
      { "<leader>lt" },
    },
    event = "VeryLazy",
    opts = {
      resolve_symbols = true,
      on_open = "panel",
      map_resize_keys = true,
      keymaps = {
        hide_cursor = true,
        map_resize_keys = true,
        no_hls = true,
        close = "q",
        expand = "l",
        collapse = "h",
      },
    },
    config = function(_, opts)
      require("litee.calltree").setup(opts)
      local wk = require("which-key")

      wk.add({
        {
          "<leader>lti",
          vim.lsp.buf.incoming_calls,
          desc = "Incoming calls tree",
        },
        {
          "<leader>lto",
          vim.lsp.buf.outgoing_calls,
          desc = "Outgoing calls tree",
        },
      })
    end,
  },
}
