return {
  "echasnovski/mini.files",
  version = false,
  keys = {
    {
      "<leader>o",
      function()
        local MiniFiles = require("mini.files")
        local name = vim.api.nvim_buf_get_name(0)
        MiniFiles.open(name)

        if name ~= "" then
          local depth = -2
          local cwd = vim.loop.cwd()
          if cwd then
            local _, init = name:find(vim.pesc(cwd))
            while init do
              depth = depth + 1
              init = name:find("/", init + 1)
            end

            for _ = 1, depth do
              MiniFiles.go_out()
            end
            for _ = 1, depth do
              MiniFiles.go_in()
            end
          end
        end
      end,
      desc = "Mini Files",
    },
  },
  opts = {
    windows = {
      preview = true,
      -- Width of focused window
      width_focus = 20,
      -- Width of non-focused window
      width_nofocus = 15,
      width_preview = 100,
    },
    mappings = {
      close = "q",
      go_in = "l",
      go_in_plus = "<cr>",
      go_out = "h",
      go_out_plus = "H",
      reset = "<esc>",
      show_help = "g?",
      synchronize = "=",
      trim_left = "<",
      trim_right = ">",
    },
  },
  config = function(_, opts)
    local MiniFiles = require("mini.files")
    MiniFiles.setup(opts)
    local show_dotfiles = true

    local filter_show = function(_)
      return true
    end

    local filter_hide = function(fs_entry)
      return not vim.startswith(fs_entry.name, ".")
    end

    local toggle_dotfiles = function()
      show_dotfiles = not show_dotfiles
      local new_filter = show_dotfiles and filter_show or filter_hide
      MiniFiles.refresh({ content = { filter = new_filter } })
    end

    vim.api.nvim_create_autocmd("User", {
      pattern = "MiniFilesBufferCreate",
      callback = function(args)
        local buf_id = args.data.buf_id
        -- Tweak left-hand side of mapping to your liking
        vim.keymap.set("n", "gh", toggle_dotfiles, { buffer = buf_id })
      end,
    })

    local map_split = function(buf_id, lhs, direction)
      local rhs = function()
        -- Make new window and set it as target
        local new_target_window
        local current_target_window = MiniFiles.get_target_window()

        if current_target_window then
          vim.api.nvim_win_call(current_target_window, function()
            vim.cmd(direction .. " split")
            new_target_window = vim.api.nvim_get_current_win()
          end)
        end

        MiniFiles.set_target_window(new_target_window)
      end

      -- Adding `desc` will result into `show_help` entries
      local desc = "Split " .. direction
      vim.keymap.set("n", lhs, rhs, { buffer = buf_id, desc = desc })
    end

    vim.api.nvim_create_autocmd("User", {
      pattern = "MiniFilesBufferCreate",
      callback = function(args)
        local buf_id = args.data.buf_id
        -- Tweak keys to your liking
        map_split(buf_id, "gs", "belowright horizontal")
        map_split(buf_id, "gv", "belowright vertical")
      end,
    })

    local files_set_cwd = function(path)
      -- Works only if cursor is on the valid file system entry
      local cur_entry_path = MiniFiles.get_fs_entry().path
      local cur_directory = vim.fs.dirname(cur_entry_path)
      vim.fn.chdir(cur_directory)
    end

    vim.api.nvim_create_autocmd("User", {
      pattern = "MiniFilesBufferCreate",
      callback = function(args)
        vim.keymap.set("n", "g.", files_set_cwd, { buffer = args.data.buf_id })
      end,
    })

    
  end,
}
