local M = {
  "nvim-lualine/lualine.nvim",
  event = "VeryLazy",
  dependencies = {
    {
      "kyazdani42/nvim-web-devicons",
    },
  },
}

local function set_theme(config)
  local theme = vim.g.colors_name

  if theme == "kanagawa" then
    local kw = require("lualine.themes.kanagawa")
    config.options.theme = kw
  elseif theme == "catppuccin" then
    local cp = require("lualine.themes.catppuccin")
    local palette = cp.get_palette("mocha")
    cp.normal.c.bg = palette.surface0
    config.optiona.tjeme = cp
  end
end

function M.config()
  local lualine = require("lualine")

  local function get_lsp_client_names()
    local clients = ""
    for _, client in pairs(vim.lsp.get_active_clients({ bufnr = 0 })) do
      clients = clients .. " •" .. client.name
    end
    if clients ~= "" then
      return "[" .. clients .. " ]"
    end
    return ""
  end

  local function get_lsp_clients()
    local clients = {}
    for _, client in pairs(vim.lsp.get_active_clients()) do
      table.insert(clients, {
        color = "red",
        fmt = "",
      })
      table.insert(clients, {
        color = "green",
        fmt = client.name,
      })
      clients = clients .. " •" .. client.name
    end
    return clients
  end

  local function show_macro_recording()
    local recording_register = vim.fn.reg_recording()
    if recording_register == "" then
      return ""
    else
      return ("Recording @" .. recording_register)
    end
  end

  local function get_nrepl_status()
    if vim.bo.filetype == "clojure" then
      local repl_finder = require("config.tools.nrepl")
      local repl_status = repl_finder.get_repl_status("no REPL")
      return repl_status
    end
    return ""
  end

  local config = {
    options = {
      icons_enabled = true,
      globalstatus = true,
      component_separators = { left = "", right = "" },
      section_separators = { left = "", right = "" },
      disabled_filetypes = {},
    },
    sections = {
      lualine_a = { "mode" },
      lualine_b = {
        "diagnostics",
        "diff",
        { fmt = show_macro_recording, "macro-recording" },
      },
      lualine_c = {
        {
          path = 1,
          "filename",
          fmt = function(filename)
            if #filename > 80 then
              filename = vim.fs.basename(filename)
            end
            return filename
          end,
        },
      },
      lualine_x = {
        {
          require("lazy.status").updates,
          cond = require("lazy.status").has_updates,
          color = { fg = "#ff9e64" },
        },
        {
          fmt = get_lsp_client_names,
          color = {
            fg = "#9BB0A5",
          },
          "lsp_clients",
        },
        {
          color = "user.repl.statusline",
          fmt = get_nrepl_status,
          "repl_status",
        },
        "progress",
      },
      lualine_y = { "filetype" },
      lualine_z = { "branch" },
    },
    tabline = {},
    extensions = {},
  }

  set_theme(config)

  lualine.setup(config)

  local function refresh()
    return lualine.refresh({ place = { "statusline" } })
  end

  vim.api.nvim_create_autocmd("RecordingEnter", { callback = refresh })

  local function on_recording_leave()
    local timer = vim.loop.new_timer()

    return timer:start(30, 0, vim.schedule_wrap(refresh))
  end

  vim.api.nvim_create_autocmd(
    "RecordingLeave",
    { callback = on_recording_leave }
  )
end

return M
