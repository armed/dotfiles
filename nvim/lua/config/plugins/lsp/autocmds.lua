local M = {}

function M.setup()
  local lsp_group = vim.api.nvim_create_augroup("LspGroup", { clear = true })

  vim.api.nvim_create_autocmd("BufWritePost", {
    group = lsp_group,
    callback = vim.lsp.codelens.refresh,
  })

  vim.api.nvim_create_autocmd("LspDetach", {
    group = lsp_group,
    callback = function(args)
      local bufnr = args.buf
      local client_id = args.data.client_id
      if client_id == nil then
        return
      end
      if vim.api.nvim_buf_is_valid(bufnr) then
        if next(vim.lsp.codelens.get(bufnr)) ~= nil then
          vim.lsp.codelens.clear(client_id, bufnr)
        end
      end
    end,
  })

  vim.api.nvim_create_autocmd("LspAttach", {
    group = lsp_group,
    callback = function(args)
      local wk = require("which-key")
      local bindings = require("config.plugins.lsp.bindings")
      local bufnr = args.buf
      local client = vim.lsp.get_client_by_id(args.data.client_id)
      if client and client.server_capabilities.codeLensProvider then
        vim.lsp.codelens.refresh()
      end
      local wk_bindings = bindings.setup()
      wk.register(wk_bindings, { noremap = true, buffer = bufnr })
    end,
  })

end

return M
