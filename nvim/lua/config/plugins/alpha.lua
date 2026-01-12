local M = {
  "goolord/alpha-nvim",
  lazy = false,
}

local function bmw_m(dashboard)
  vim.api.nvim_set_hl(0, "BMWLightBlue", { fg = "#1BADE3" })
  vim.api.nvim_set_hl(0, "BMWDarkBlue", { fg = "#0C4DA2" })
  vim.api.nvim_set_hl(0, "BMWRed", { fg = "#E4032E" })
  vim.api.nvim_set_hl(0, "BMWWhite", { fg = "#FFFFFF" })
  -- BMW M Logo ASCII Art
  dashboard.section.header.val = {
    [[⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⣠⣤⣤⣤⣤⣤⣤⡤⠀⠀⣠⣤⣤⣤⣤⣤⣤⡤⠀⠀⣠⣤⣤⣤⣤⣤⣤⡤  ⣠⣤⣤⣤⣤⣤⠀⠀⠀⠀⢀⣤⣤⣤⣤⣤⣤  ]],
    [[⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⣠⣾⣿⣿⣿⣿⣿⡿⠋⠀⣠⣾⣿⣿⣿⣿⣿⡿⠋⠀⣠⣾⣿⣿⣿⣿⣿⡿⠋ ⣠⣾⣿⣿⣿⣿⣿⣿⠀⠀⢀⣴⣿⣿⣿⣿⣿⣿⣿⠀ ]],
    [[⠀⠀⠀⠀⠀⠀⠀⠀⠀⣠⣾⣿⣿⣿⣿⣿⡿⠋⠀⣠⣾⣿⣿⣿⣿⣿⡿⠋⠀⣠⣾⣿⣿⣿⣿⣿⡿⠋ ⣠⣾⣿⣿⣿⣿⣿⣿⣿⣿⢀⣴⣿⣿⣿⣿⣿⣿⣿⣿⣿⠀ ]],
    [[⠀⠀⠀⠀⠀⠀⠀⣠⣾⣿⣿⣿⣿⣿⡿⠋⠀⣠⣾⣿⣿⣿⣿⣿⡿⠋⠀⣠⣾⣿⣿⣿⣿⣿⡿⠋ ⣠⣾⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿ ⠀]],
    [[⠀⠀⠀⠀⠀⣠⣾⣿⣿⣿⣿⣿⡿⠋⠀⣠⣾⣿⣿⣿⣿⣿⡿⠋⠀⣠⣾⣿⣿⣿⣿⣿⡿⠋⠀⣠⣾⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⠀ ]],
    [[⠀⠀⠀⣠⣾⣿⣿⣿⣿⣿⡿⠋ ⣠⣾⣿⣿⣿⣿⣿⡿⠋ ⣠⣾⣿⣿⣿⣿⣿⡿⠋ ⣠⣾⣿⣿⣿⣿⣿⣿⡿⠋⢸⣿⣿⣿⣿⣿⣿⣿⡿⠋⢸⣿⣿⣿⣿⣿⣿  ]],
    [[⠀⣠⣾⣿⣿⣿⣿⣿⡿⠋⠀⣠⣾⣿⣿⣿⣿⣿⡿⠋⠀⣠⣾⣿⣿⣿⣿⣿⡿⠋ ⣠⣾⣿⣿⣿⣿⣿⣿⡿⠋⠀⠀⢸⣿⣿⣿⣿⣿⡿⠋  ⢸⣿⣿⣿⣿⣿⣿  ]],
    [[⠀⠉⠉⠉⠉⠉⠉⠉  ⠀⠉⠉⠉⠉⠉⠉⠉⠀ ⠀⠉⠉⠉⠉⠉⠉⠉   ⠉⠉⠉⠉⠉⠉⠉⠉⠀⠀⠀⠀⠈⠉⠉⠉⠉⠉ ⠀  ⠈⠉⠉⠉⠉⠉⠉  ]],
  }

  -- Apply colors to header lines
  dashboard.section.header.opts.hl = {
    {
      { "BMWLightBlue", 0, 62 },
      { "BMWDarkBlue", 62, 97 },
      { "BMWRed", 97, 121 },
      { "BMWWhite", 121, -1 },
    },
    {
      { "BMWLightBlue", 0, 60 },
      { "BMWDarkBlue", 60, 92 },
      { "BMWRed", 92, 118 },
      { "BMWWhite", 118, -1 },
    },
    {
      { "BMWLightBlue", 0, 56 },
      { "BMWDarkBlue", 56, 82 },
      { "BMWRed", 82, 112 },
      { "BMWWhite", 112, -1 },
    },
    {
      { "BMWLightBlue", 0, 50 },
      { "BMWDarkBlue", 50, 76 },
      { "BMWRed", 76, 106 },
      { "BMWWhite", 106, -1 },
    },
    {
      { "BMWLightBlue", 0, 44 },
      { "BMWDarkBlue", 44, 70 },
      { "BMWRed", 70, 100 },
      { "BMWWhite", 100, -1 },
    },
    {
      { "BMWLightBlue", 0, 36 },
      { "BMWDarkBlue", 36, 62 },
      { "BMWRed", 62, 92 },
      { "BMWWhite", 92, -1 },
    },
    {
      { "BMWLightBlue", 0, 28 },
      { "BMWDarkBlue", 28, 58 },
      { "BMWRed", 58, 88 },
      { "BMWWhite", 88, -1 },
    },
    {
      { "BMWLightBlue", 0, 24 },
      { "BMWDarkBlue", 24, 48 },
      { "BMWRed", 48, 78 },
      { "BMWWhite", 78, -1 },
    },
  }

  -- Add 20 lines of padding before the header in layout
  local layout = {
    { type = "padding", val = 20 },
  }
  for _, item in ipairs(dashboard.config.layout) do
    table.insert(layout, item)
  end
  dashboard.config.layout = layout
end

local function k16(dashboard)
  local main_color = "Function"
  local num_color = "Macro"

  dashboard.section.header.opts.hl = {
    {
      { main_color, 0, 128 },
      { num_color, 128, 200 },
    },
    {
      { main_color, 0, 128 },
      { num_color, 128, 200 },
    },
    {
      { main_color, 0, 128 },
      { num_color, 128, 200 },
    },
    {
      { main_color, 0, 128 },
      { num_color, 128, 200 },
    },
    {
      { main_color, 0, 128 },
      { num_color, 128, 200 },
    },
    {
      { main_color, 0, 132 },
      { num_color, 132, 200 },
    },
    {
      { main_color, 0, 124 },
      { num_color, 124, 200 },
    },
    {
      { main_color, 0, 124 },
      { num_color, 124, 200 },
    },
    {
      { main_color, 0, 126 },
      { num_color, 126, 200 },
    },
    {
      { main_color, 0, 130 },
      { num_color, 130, 200 },
    },
  }

  dashboard.section.header.val = {
    "",
    "",
    "",
    "",
    "██╗  ██╗███████╗██████╗ ██╗     ███████╗██████╗      ██╗ ██████╗",
    "██║ ██╔╝██╔════╝██╔══██╗██║     ██╔════╝██╔══██╗    ███║██╔════╝",
    "█████╔╝ █████╗  ██████╔╝██║     █████╗  ██████╔╝    ╚██║███████╗",
    "██╔═██╗ ██╔══╝  ██╔═══╝ ██║     ██╔══╝  ██╔══██╗     ██║██╔═══██╗",
    "██║  ██╗███████╗██║     ███████╗███████╗██║  ██║     ██║╚██████╔╝",
    "╚═╝  ╚═╝╚══════╝╚═╝     ╚══════╝╚══════╝╚═╝  ╚═╝     ╚═╝ ╚═════╝",
    "",
    "",
  }
end

function M.config()
  local alpha = require("alpha")
  local dashboard = require("alpha.themes.dashboard")

  bmw_m(dashboard)

  dashboard.section.buttons.val = {
    dashboard.button("f", "󰮗  > Find file", ":Telescope find_files<CR>"),
    dashboard.button("r", "  > Recent", ":Telescope oldfiles<CR>"),
    dashboard.button("q", "󰗼  > Quit NVIM", ":qa<CR>"),
  }

  alpha.setup(dashboard.config)

  vim.cmd("autocmd FileType alpha setlocal nofoldenable")
end

return M
