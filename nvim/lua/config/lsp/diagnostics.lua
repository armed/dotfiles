local M = {}

M.signs = {
  [vim.diagnostic.severity.ERROR] = "✘",
  [vim.diagnostic.severity.WARN] = "⚠",
  [vim.diagnostic.severity.INFO] = "ℹ",
  [vim.diagnostic.severity.HINT] = "➤",
}

function M.setup()
  vim.diagnostic.config({
    update_in_insert = true,
    signs = { text = M.signs },
    underline = true,
    severity_sort = true,
    float = { border = "rounded", source = true },
    virtual_text = false,
    virtual_lines = function(_, bufnr)
      local state = vim.b[bufnr].virtual_lines_state
      if not state or not state.enabled then
        return false
      end
      return { current_line = state.current_line }
    end,
  })
end

function M.toggle_virtual_line(is_current_line)
  local bufnr = vim.api.nvim_get_current_buf()
  local state = vim.b[bufnr].virtual_lines_state or {}
  local same_mode = state.current_line == is_current_line
  vim.b[bufnr].virtual_lines_state = {
    enabled = not (state.enabled and same_mode),
    current_line = is_current_line,
  }
  vim.diagnostic.show(nil, bufnr)
end

function M.turn_off_virtual_lines(args)
  local bufnr = args and args.buf or vim.api.nvim_get_current_buf()
  local state = vim.b[bufnr].virtual_lines_state
  if state and state.enabled then
    state.enabled = false
    vim.b[bufnr].virtual_lines_state = state
    vim.diagnostic.show(nil, bufnr)
  end
end

return M
