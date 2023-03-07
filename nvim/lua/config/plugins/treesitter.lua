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
        -- max_lines = 2,
        separator = "_",
      },
    },
  },
  event = "BufReadPost",
  build = ":TSUpdate",
}

function M.config()
  require("nvim-treesitter.configs").setup({
    ensure_installed = { "lua", "help", "clojure" },
    highlight = {
      enable = true,
      additional_vim_regex_highlighting = { "clojure" },
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
        init_selection = "<enter>",
        node_incremental = "<enter>",
        scope_incremental = "<c-s>",
        node_decremental = "<bs>",
      },
    },
    playground = {
      enable = true,
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
end

return M
