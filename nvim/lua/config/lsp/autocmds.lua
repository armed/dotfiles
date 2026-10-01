local M = {}

function M.setup()
  local lsp_group = vim.api.nvim_create_augroup("LspGroup", { clear = true })

  vim.api.nvim_create_autocmd("LspAttach", {
    group = lsp_group,
    callback = function(args)
      local bufnr = args.buf

      local wk = require("which-key")
      local keymaps = require("config.lsp.keymaps").setup()
      wk.add(keymaps, { noremap = true, buffer = bufnr })
    end,
  })

  vim.api.nvim_create_autocmd({ "CursorMoved", "CursorMovedI" }, {
    group = lsp_group,
    pattern = "*",
    callback = require("config.lsp.diagnostics").turn_off_virtual_lines,
    desc = "Turn off virtual diagnostic lines on cursor movement",
  })
end

return M
