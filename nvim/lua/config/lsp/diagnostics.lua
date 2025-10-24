local M = {}

M.signs = {
  [vim.diagnostic.severity.ERROR] = "✘",
  [vim.diagnostic.severity.WARN] = "⚠",
  [vim.diagnostic.severity.INFO] = "ℹ",
  [vim.diagnostic.severity.HINT] = "➤",
}

local defaults = { update_in_insert = true, signs = { text = M.signs, }, underline = true, }

local function merge_config(config)
  vim.diagnostic.config(config)
end

function M.setup()
  vim.diagnostic.config(defaults)
end

M.toggle_virtual_line = function(is_current_line)
  local bufnr = vim.api.nvim_get_current_buf()
  local current_line = is_current_line
      and (vim.api.nvim_win_get_cursor(0)[1] - 1)
    or nil

  local state = vim.b[bufnr].virtual_lines_state
    or { enabled = false, line = nil }

  if is_current_line then
    if state.enabled and state.line == current_line then
      state.enabled = false
      state.line = nil
    else
      state.enabled = true
      state.line = current_line
    end
  else
    state.enabled = not state.enabled
    state.line = nil
  end

  vim.b[bufnr].virtual_lines_state = state

  merge_config({
    virtual_lines = {
      format = function(diagnostic)
        if not state.enabled then
          return nil
        end
        if is_current_line and state.line ~= diagnostic.lnum then
          return nil
        end
        return diagnostic.message
      end,
    },
    virtual_text = false,
  })
end

M.turn_off_virtual_lines = function()
  local bufnr = vim.api.nvim_get_current_buf()
  local state = vim.b[bufnr].virtual_lines_state

  if not state then
    return
  end

  state.enabled = false
  state.line = nil

  vim.b[bufnr].virtual_lines_state = state

  merge_config({
    virtual_lines = {
      format = function(_)
        return nil
      end,
    },
    virtual_text = false,
  })
end

return M
