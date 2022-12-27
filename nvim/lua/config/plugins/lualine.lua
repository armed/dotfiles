local M = {
  'nvim-lualine/lualine.nvim',
  event = 'VeryLazy',
  dependencies = { 'kyazdani42/nvim-web-devicons' },
}

function M.config()
  local cp = require('catppuccin.palettes')
  local palette = cp.get_palette('mocha')
  local theme = require('lualine.themes.catppuccin')
  local lualine = require('lualine')

  theme.normal.c.bg = palette.surface0

  local function get_lsp_client_names()
    local clients = ''
    for _, client in pairs(vim.lsp.buf_get_clients()) do
      clients = clients .. '•' .. client.name
    end
    return '[' .. clients .. ']'
  end

  local function show_macro_recording()
    local recording_register = vim.fn.reg_recording()
    if (recording_register == '') then
      return ''
    else
      return ('Recording @' .. recording_register)
    end
  end

  local config = {
    options = {
      icons_enabled = true,
      globalstatus = true,
      theme = theme,
      component_separators = { left = '', right = '' },
      section_separators = { left = '', right = '' },
      disabled_filetypes = {}
    },
    sections = {
      lualine_a = { 'mode' },
      lualine_b = {
        'diagnostics', 'diff', { fmt = show_macro_recording, 'macro-recording' }
      },
      lualine_c = {
        { path = 1, 'filename' }
      },
      lualine_x = {
        { fmt = get_lsp_client_names, 'lsp_clients' },
        'progress'
      },
      lualine_y = { 'filetype' },
      lualine_z = { 'branch' }
    },
    tabline = {},
    extensions = {}
  }

  lualine.setup(config)

  local function refresh()
    return lualine.refresh({ place = { 'statusline' } })
  end
  vim.api.nvim_create_autocmd('RecordingEnter', { callback = refresh })

  local function on_recording_leave()
    local timer = vim.loop.new_timer()

    return timer:start(30, 0, vim.schedule_wrap(refresh))
  end

  vim.api.nvim_create_autocmd('RecordingLeave', { callback = on_recording_leave })
end

return M

