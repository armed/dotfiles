local M = {}

M.signs = {
  [vim.diagnostic.severity.ERROR] = "✘",
  [vim.diagnostic.severity.WARN] = "⚠",
  [vim.diagnostic.severity.INFO] = "ℹ",
  [vim.diagnostic.severity.HINT] = "➤",
}

function M.setup()
  vim.diagnostic.config({
    virtual_text = false,
    virtual_lines = false,
    signs = {
      text = M.signs,
    },
  })
end

M.toggle_virtual_line = function()
  local bufnr = vim.api.nvim_get_current_buf()
  local line = vim.api.nvim_win_get_cursor(0)[1] - 1

  local state = vim.b[bufnr].virtual_lines_state
    or { enabled = false, line = nil }
  state.enabled = not state.enabled
  vim.b[bufnr].virtual_lines_state = state

  vim.diagnostic.config({
    virtual_lines = {
      format = function(diagnostic)
        if state.enabled then
          return diagnostic.message
        end
        return nil
      end,
    },
    virtual_text = false,
  })

  vim.diagnostic.show()
end

M.turn_off_virtual_lines = function()
  vim.diagnostic.config({
    virtual_lines = false,
    virtual_text = false,
  })
  vim.diagnostic.show()
end

return M
