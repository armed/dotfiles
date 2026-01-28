local api = require("nvim-tree.api")
local utils = require("nvim-tree.utils")
local core = require("nvim-tree.core")

local function current_node_path()
  local cwd = core.get_cwd()
  local abs_path = api.tree.get_node_under_cursor().absolute_path
  return utils.path_relative(abs_path, cwd)
end

local function current_dir_path()
  local path = current_node_path()

  if vim.fn.filereadable(path) == 1 then
    path = vim.fn.fnamemodify(path, ":h")
  end

  return path
end

local function grep_in_folder()
  vim.cmd([[FzfLua grep_project cwd=]] .. current_dir_path())
end

local function find_in_folder()
  require("fff").find_files_in_dir(current_dir_path())
end

local function run_clojure_tests_in_path()
  require("clojure-test.api").run_tests_in_path(current_node_path())
end

return {
  "nvim-tree/nvim-tree.lua",
  version = "1.14.0",
  event = "VeryLazy",
  dependencies = {
    "nvim-tree/nvim-web-devicons",
  },
  config = function()
    local VIEW_WIDTH_FIXED = 30
    local view_width_max = VIEW_WIDTH_FIXED -- fixed to start

    local function toggle_width_adaptive()
      if view_width_max == -1 then
        view_width_max = VIEW_WIDTH_FIXED
      else
        view_width_max = -1
      end

      require("nvim-tree.api").tree.reload()
    end

    local function get_view_width_max()
      return view_width_max
    end

    require("nvim-tree").setup({
      actions = {
        open_file = {
          window_picker = {
            chars = "FJNVURKDIEMCYBOWPQALZMXC1234567890",
            exclude = {
              buftype = { "terminal", "help" },
            },
          },
        },
      },
      view = {
        width = {
          min = 30,
          max = get_view_width_max,
        },
      },
      update_focused_file = {
        enable = true,
      },
      prefer_startup_root = false,
      sync_root_with_cwd = false,
      diagnostics = {
        enable = true,
        show_on_dirs = true,
        show_on_open_dirs = false,
        severity = {
          min = vim.diagnostic.severity.ERROR,
          max = vim.diagnostic.severity.ERROR,
        },
        icons = {
          hint = "",
          info = "",
          warning = "",
          error = "",
        },
      },
      renderer = {
        highlight_git = "name",
        highlight_diagnostics = "none",
        icons = {
          show = {
            diagnostics = true,
          },
          git_placement = "after",
          diagnostics_placement = "signcolumn",
          glyphs = {
            default = "",
            symlink = "",
            bookmark = "󰆤",
            modified = "●",
            hidden = "󰜌",
            folder = {
              arrow_closed = "",
              arrow_open = "",
              default = "",
              open = "",
              empty = "",
              empty_open = "",
              symlink = "",
              symlink_open = "",
            },
            git = {
              unstaged = "",
              staged = "󰸞",
              unmerged = "",
              renamed = "➜",
              untracked = "󱇬",
              deleted = "",
              ignored = "◌",
            },
          },
        },
      },
      on_attach = function(bufnr)
        local function opts(desc)
          return {
            desc = "Tree: " .. desc,
            buffer = bufnr,
            noremap = true,
            silent = true,
          }
        end

        api.config.mappings.default_on_attach(bufnr)

        vim.keymap.set(
          "n",
          "e",
          toggle_width_adaptive,
          opts("Toggle Adaptive Width")
        )
      end,
    })

    local wk = require("which-key")

    wk.add({
      { "<leader>e", group = "Neotree" },
      { "<leader>ee", "<cmd>NvimTreeOpen<cr>", desc = "Show/focus" },
      { "<leader>eq", "<cmd>NvimTreeClose<cr>", desc = "Close" },
      { "<leader>eg", grep_in_folder, desc = "Grep files in folder" },
      { "<leader>ef", find_in_folder, desc = "Find files in folder" },
      {
        "<localleader>et",
        run_clojure_tests_in_path,
        desc = "Run clojure tests in path",
      },
    })
  end,
}
