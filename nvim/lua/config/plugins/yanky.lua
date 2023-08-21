return {
  "gbprod/yanky.nvim",
  enabled = false,
  dependencies = {
    { "kkharji/sqlite.lua" },
  },
  opts = function()
    local mapping = require("yanky.telescope.mapping")
    local mappings = mapping.get_defaults()
    mappings.i["<c-k>"] = nil
    mappings.i["<c-p>"] = nil
    mappings.i["<c-]>"] = mapping.put("p")
    mappings.i["<c-[>"] = mapping.put("P")
    return {
      highlight = { timer = 150 },
      preserve_cursor_position = { enabled = true },
      ring = { storage = "sqlite" },
      picker = {
        telescope = {
          use_default_mappings = false,
          mappings = mappings,
        },
      },
    }
  end,
  keys = {
    {
      "<leader>p",
      function()
        require("telescope").extensions.yank_history.yank_history({})
      end,
      desc = "Open Yank History",
    },
    { "y", "<Plug>(YankyYank)", mode = { "n", "x" }, desc = "Yank text" },
    {
      "p",
      "<Plug>(YankyPutAfter)",
      mode = { "n", "x" },
      desc = "Put yanked text after cursor",
    },
    {
      "P",
      "<Plug>(YankyPutBefore)",
      mode = { "n", "x" },
      desc = "Put yanked text before cursor",
    },
    {
      "gp",
      "<Plug>(YankyGPutAfter)",
      mode = { "n", "x" },
      desc = "Put yanked text after selection",
    },
    {
      "gP",
      "<Plug>(YankyGPutBefore)",
      mode = { "n", "x" },
      desc = "Put yanked text before selection",
    },
    {
      "[y",
      "<Plug>(YankyCycleForward)",
      desc = "Cycle forward through yank history",
    },
    {
      "]y",
      "<Plug>(YankyCycleBackward)",
      desc = "Cycle backward through yank history",
    },
    {
      "]p",
      "<Plug>(YankyPutIndentAfterLinewise)",
      desc = "Put indented after cursor (linewise)",
    },
    {
      "[p",
      "<Plug>(YankyPutIndentBeforeLinewise)",
      desc = "Put indented before cursor (linewise)",
    },
    {
      "]P",
      "<Plug>(YankyPutIndentAfterLinewise)",
      desc = "Put indented after cursor (linewise)",
    },
    {
      "[P",
      "<Plug>(YankyPutIndentBeforeLinewise)",
      desc = "Put indented before cursor (linewise)",
    },
    {
      ">p",
      "<Plug>(YankyPutIndentAfterShiftRight)",
      desc = "Put and indent right",
    },
    {
      "<p",
      "<Plug>(YankyPutIndentAfterShiftLeft)",
      desc = "Put and indent left",
    },
    {
      ">P",
      "<Plug>(YankyPutIndentBeforeShiftRight)",
      desc = "Put before and indent right",
    },
    {
      "<P",
      "<Plug>(YankyPutIndentBeforeShiftLeft)",
      desc = "Put before and indent left",
    },
    {
      "=p",
      "<Plug>(YankyPutAfterFilter)",
      desc = "Put after applying a filter",
    },
    {
      "=P",
      "<Plug>(YankyPutBeforeFilter)",
      desc = "Put before applying a filter",
    },
  },
}

