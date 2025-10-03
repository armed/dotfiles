local M = {
  "nvim-treesitter/nvim-treesitter",
  dependencies = {
    {
      "nvim-treesitter/nvim-treesitter-context",
      opts = {
        enable = false,
        patterns = {
          clojure = {
            "list_lit",
            "vec_lit",
            "map_lit",
            "set_lit",
          },
        },
        max_lines = 2,
        separator = "_",
      },
    },
  },
  event = "BufReadPost",
  build = ":TSUpdate",
}

function M.config()
  ---@diagnostic disable-next-line: missing-fields
  require("nvim-treesitter.configs").setup({
    sync_install = true,
    ensure_installed = { "lua", "clojure" },
    highlight = {
      enable = true,
      disable = function(_, buf)
        local max_filesize = 200 * 1024 -- 200 KB
        local ok, stats =
          pcall(vim.loop.fs_stat, vim.api.nvim_buf_get_name(buf))
        if ok and stats and stats.size > max_filesize then
          return true
        end
      end,
    },
    indent = { enable = true },
    query_linter = {
      enable = true,
      use_virtual_text = true,
      lint_events = { "BufWrite", "CursorHold" },
    },
    refactor = {
      enable = true,
      highlight_definitions = {
        enable = true,
        clear_on_cursor_move = true,
      },
      navigation = { enable = true },
    },
    incremental_selection = {
      enable = true,
      keymaps = {
        init_selection = "<CR>",
        node_incremental = "<CR>",
        scope_incremental = "<c-s>",
        node_decremental = "<BS>",
      },
    },
  })
end

return M
