local M = {
  'nvim-zh/auto-save.nvim',
  enabled = true,
  event = 'BufReadPost',
  config = {
    execution_message = { message = function () return '' end },
    trigger_events = { 'BufLeave', 'FocusLost' },
    condition = function (buf)
      local vf = vim.fn
      return vf.getbufvar(buf, '&modifiable') == 1
    end
  }
}

return M

