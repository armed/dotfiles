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

  -- Get or initialize buffer-local state
  local state = vim.b[bufnr].virtual_lines_state
    or { enabled = false, line = nil }
  state.enabled = not state.enabled
  -- state.line = state.enabled and line or nil
  vim.b[bufnr].virtual_lines_state = state

  -- Configure diagnostics with virtual_lines
  vim.diagnostic.config({
    virtual_lines = {
      -- Custom handler to filter diagnostics by line
      format = function(diagnostic)
        -- if state.enabled and diagnostic.lnum == state.line then
        if state.enabled then
          return diagnostic.message
        end
        return nil -- Returning nil skips rendering for this diagnostic
      end,
    },
    virtual_text = false, -- Optional: disable virtual text to avoid overlap
  })

  -- Refresh diagnostics to apply changes
  vim.diagnostic.show()
end

return M
