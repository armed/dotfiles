local M = {}

local function supports_codelens(client)
  return client and client.server_capabilities.codeLensProvider
end

local diagnostic = require("config.lsp.diagnostics")

function M.setup()
  local lsp_group = vim.api.nvim_create_augroup("LspGroup", { clear = true })

  vim.api.nvim_create_autocmd("LspAttach", {
    group = lsp_group,
    callback = function(args)
      local bufnr = args.buf
      local client = vim.lsp.get_client_by_id(args.data.client_id)
      if supports_codelens(client) then
        vim.lsp.codelens.refresh({ bufnr = 0 })
      end

      local wk = require("which-key")
      local keymaps = require("config.lsp.keymaps").setup()
      wk.add(keymaps, { noremap = true, buffer = bufnr })
    end,
  })

  vim.api.nvim_create_autocmd("CursorMoved", {
    group = lsp_group,
    pattern = "*",
    callback = diagnostic.turn_off_virtual_lines,
    desc = "Turn off virtual diagnostic lines on cursor movement",
  })

  vim.api.nvim_create_autocmd("FileType", {
    pattern = "lazy",
    callback = function(event)
      vim.diagnostic.enable(false, { bufnr = event.buf })
    end,
    desc = "No diagnostic for lazy window",
  })
end

return M
