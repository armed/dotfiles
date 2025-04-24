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
  -- vim.cmd("hi TreesitterContextBottom gui=underline guisp=DarkGray")

  ---@diagnostic disable-next-line: missing-fields
  require("nvim-treesitter.configs").setup({
    autotag = {
      enabled = true,
      filetypes = { "html", "xml", "typescriptreact" },
    },
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
    playground = {
      enable = false,
      disable = {},
      updatetime = 100,
      keybindings = {
        toggle_query_editor = "o",
        toggle_hl_groups = "i",
        toggle_injected_languages = "t",
        toggle_anonymous_nodes = "a",
        toggle_language_display = "I",
        focus_language = "f",
        unfocus_language = "F",
        update = "R",
        goto_node = "<cr>",
        show_help = "?",
      },
      persist_queries = false,
    },
  })

  local parser_config = require("nvim-treesitter.parsers").get_parser_configs()

  parser_config.clojure = {
    install_info = {
      url = "https://github.com/julienvincent/tree-sitter-clojure",
      revision = "5cf3c430a3d98cfd2191b420caee1b4b36e5e917",
      files = { "src/parser.c" },
      generate_requires_npm = false,
      requires_generate_from_grammar = false,
    },
  }
end

return M
