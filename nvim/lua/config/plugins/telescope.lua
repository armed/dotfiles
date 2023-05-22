local M = {
  "nvim-telescope/telescope.nvim",
  cmd = "Telescope",
  branch = "0.1.x",
  keys = {
    { "<leader>f", desc = "Telescope find" },
    { "<leader>r", desc = "Resume last search" },
  },
  dependencies = {
    "tsakirist/telescope-lazy.nvim",
    "aaronhallaert/advanced-git-search.nvim",
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
  local trouble = require("trouble.providers.telescope")
  local telescope = require("telescope")
  local actions = require("telescope.actions")
  local themes = require("telescope.themes")

  telescope.setup({
    defaults = {
      layout_config = {
        vertical = { width = 0.9 },
      },
      dynamic_preview_title = true,
      layout_strategy = "vertical",
      mappings = {
        n = {
          ["q"] = actions.close,
          ["<c-t>"] = trouble.open_with_trouble,
        },
        i = {
          ["<C-j>"] = actions.move_selection_next,
          ["<C-k>"] = actions.move_selection_previous,
          ["<c-t>"] = trouble.open_with_trouble,
        },
      },
      vimgrep_arguments = {
        "rg",
        -- search all known types
        "--type=all",
        -- ignore this dirs
        "--glob=!**/.git/*",
        "--glob=!**/node_modules/*",
        "--glob=!**/.next/*",
        "--glob=!**/target/*",
        "--glob=!**/.shadow-cljs/*",
        "--glob=!**/.cpcache/*",
        "--glob=!**/.cache/*",
        "--glob=!*-lock.*",
        "--glob=!*.log",
        -- limit of sin, lines longer than 150 is not relevant
        "--max-columns=150",
        "--hidden",
        "--no-ignore-vcs",
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
    pickers = {
      registers = {
        layout_config = {
          vertical = { width = 0.9 },
        },
        enable_preview = true,
        dynamic_preview_title = true,
        layout_strategy = "vertical",
      },
      find_files = {
        find_command = {
          "rg",
          "--files",
          "--hidden",
          "--ignore",
          "-u",
          "--trim",
          "--smart-case",
          "--max-columns=150",
          "--glob=!**/gen/*",
          "--glob=!**/static/js/*",
          "--glob=!**/.git/*",
          "--glob=!**/node_modules/*",
          "--glob=!**/.next/*",
          "--glob=!**/target/*",
          "--glob=!**/.shadow-cljs/*",
          "--glob=!**/.cpcache/*",
          "--glob=!**/.cache/*",
          "--glob=!*-lock.*",
          "--glob=!*.log",
        },
      },
    },
  })
  telescope.load_extension("advanced_git_search")
  telescope.load_extension("ui-select")
  telescope.load_extension("fzf")
  telescope.load_extension("workspaces")
  telescope.load_extension("lazy")

  local wk = require("which-key")
  wk.register({
    r = { ":Telescope resume<cr>", "Resume last search" },
    f = {
      F = { ":FzfLua<cr>", "Fzf" },
      f = { ":Telescope find_files<cr>", "Files" },
      c = { ":Telescope current_buffer_fuzzy_find<cr>", "In buffer" },
      g = { ":Telescope live_grep<cr>", "Live grep" },
      b = { ":Telescope buffers<cr>", "Buffers" },
      k = { ":Telescope keymaps<cr>", "Keymaps" },
      r = { ":Telescope oldfiles cwd_only=true<cr>", "Recent files" },
    },
  }, { prefix = "<leader>" })
end

return M
