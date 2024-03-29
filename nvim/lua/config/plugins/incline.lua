local M = {
  "b0o/incline.nvim",
  event = "VeryLazy",
  dependencies = {
    "kyazdani42/nvim-web-devicons",
  },
}

local function render_fn(props)
  local nwd = require("nvim-web-devicons")
  local icons = require("config.icons")
  local bufname = vim.api.nvim_buf_get_name(props.buf)
  local filename = vim.fn.fnamemodify(bufname, ":t")

  if filename == "" then
    return false
  end

  local render_spec = {}
  local modified
  if vim.api.nvim_buf_get_option(props.buf, "modified") then
    modified = icons.ui.BigCircle
  else
    modified = ""
  end
  local location = ""
  -- if (props.focused and navic.is_available()) then
  --   location = (navic.get_location() .. ' @ ')
  -- else
  --   location = ''
  -- end
  local filetype_icon, _ = nwd.get_icon_color(filename)
  local buffer = {
    { guifg = "black", filetype_icon },
    { " " },
    { gui = "bold", location },
    { (modified .. filename), guifg = "black", gui = "bold" },
  }
  for _, buffer_ in ipairs(buffer) do
    table.insert(render_spec, buffer_)
  end
  return render_spec
end

function M.config()
  require("incline").setup({
    debounce_threshold = {
      falling = 250,
      rising = 250,
    },
    window = {
      margin = {
        vertical = 1,
        horizontal = 0,
      },
    },
    hide = { cursorline = true },
    highlight = {
      groups = {
        InclineNormal = { default = true, group = "user.win.title" },
        InclineNormalNC = { default = true, group = "user.win.title" },
      },
    },
    render = render_fn,
  })
end

return M
