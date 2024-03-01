local M = {}

local function supports_codelens(client)
  return client and client.server_capabilities.codeLensProvider
end

function M.setup()
  local lsp_group = vim.api.nvim_create_augroup("LspGroup", { clear = true })

  vim.api.nvim_create_autocmd({ "BufWritePost", "BufWinEnter" }, {
    group = lsp_group,
    callback = function()
      vim.lsp.codelens.refresh({ bufnr = 0 })
    end,
  })

  vim.api.nvim_create_autocmd("LspDetach", {
    group = lsp_group,
    callback = function(args)
      local bufnr = args.buf
      local client_id = args.data.client_id
      if client_id == nil then
        return
      end
      local client = vim.lsp.get_client_by_id(args.data.client_id)
      if supports_codelens(client) then
        if vim.api.nvim_buf_is_valid(bufnr) then
          if next(vim.lsp.codelens.get(bufnr)) ~= nil then
            vim.lsp.codelens.clear(client_id, bufnr)
          end
        end
      end
    end,
  })

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
      wk.register(keymaps, { noremap = true, buffer = bufnr })
    end,
  })
end

return M
