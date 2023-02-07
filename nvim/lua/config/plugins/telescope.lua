local M = {
  "nvim-telescope/telescope.nvim",
  cmd = "Telescope",
  branch = "0.1.x",
  dependencies = {
    "tsakirist/telescope-lazy.nvim",
    "nvim-lua/plenary.nvim",
    "nvim-telescope/telescope-ui-select.nvim",
    "natecraddock/workspaces.nvim",
    {
      "nvim-telescope/telescope-fzf-native.nvim",
      build = "make",
    },
  },
}

function M.config()
  local telescope = require("telescope")
  local actions = require("telescope.actions")
  local themes = require("telescope.themes")

  telescope.setup({
    defaults = {
      file_ignore_patterns = {
        "node_modules",
        "target",
        ".cpcache",
        ".cache",
        ".git",
        "tmp",
      },
      mappings = {
        n = {
          ["q"] = actions.close,
        },
        i = {
          -- ["<esc><esc>"] = actions.close,
          ["<C-j>"] = actions.move_selection_next,
          ["<C-k>"] = actions.move_selection_previous,
        },
      },
      vimgrep_arguments = {
        "rg",
        -- search all known types
        "--type=all",
        -- ignore this dirs
        "--glob=!.git/*",
        "--glob=!node_modules/*",
        "--glob=!.cpcache/*",
        "--glob=!.cache/*",
        "--glob=!target/*",
        "--glob=!tmp/*",
        "--glob=!*.log",
        -- limit of sin, lines longer than 150 is not relevant
        "--max-columns=150",
        "--hidden",
        "--no-ignore",
        "--color=never",
        "--no-heading",
        "--with-filename",
        "--line-number",
        "--column",
        "--smart-case",
        "--trim",
      },
    },
    extensions = {
      ["ui-select"] = { themes.get_dropdown({}) },
      fzf = {
        fuzzy = true,
        override_generic_sorter = true,
        override_file_sorter = true,
        case_mode = "smart_case",
      },
      lazy = {
        -- Optional theme (the extension doesn't set a default theme)
        theme = "ivy",
        -- Whether or not to show the icon in the first column
        show_icon = true,
        -- Mappings for the actions
        mappings = {
          open_in_browser = "<C-o>",
          open_in_file_browser = "<M-b>",
          open_in_find_files = "<C-f>",
          open_in_live_grep = "<C-g>",
          open_plugins_picker = "<C-b>", -- Works only after having called first another action
          open_lazy_root_find_files = "<C-r>f",
          open_lazy_root_live_grep = "<C-r>g",
        },
        -- Other telescope configuration options
      },
    },
  })
  telescope.load_extension("ui-select")
  telescope.load_extension("fzf")
  telescope.load_extension("workspaces")
  telescope.load_extension("lazy")
end

return M
