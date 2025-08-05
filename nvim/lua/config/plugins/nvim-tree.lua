return {
  "nvim-tree/nvim-tree.lua",
  version = "*",
  event = "VeryLazy",
  dependencies = {
    "nvim-tree/nvim-web-devicons",
  },
  config = function()
    local api = require("nvim-tree.api")

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
    })
  end,
}
