local M = {
  "nvim-zh/auto-save.nvim",
  enabled = true,
  event = { "BufReadPost", "BufNewFile" },
  opts = {
    execution_message = {
      message = function()
        return ""
      end,
    },
    trigger_events = { "BufLeave", "FocusLost" },
    condition = function(buf)
      if not vim.api.nvim_buf_is_valid(buf) then
        return false
      end
      local bo = vim.bo[buf]
      return bo.modifiable
        and not bo.readonly
        and not bo.binary
        and bo.buftype == ""
        and vim.api.nvim_buf_get_name(buf) ~= ""
    end,
  },
}

return M
