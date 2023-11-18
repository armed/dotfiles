local M = {}

local function supports_codelens(client)
  return client and client.server_capabilities.codeLensProvider
end

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
        vim.lsp.codelens.refresh()
      end

      local wk = require("which-key")
      local keymaps = require("config.lsp.keymaps").setup()
      wk.register(keymaps, { noremap = true, buffer = bufnr })
    end,
  })

  vim.api.nvim_create_autocmd("LspRequest", {
    callback = function(args)
      local bufnr = args.buf
      local client_id = args.data.client_id
      local request_id = args.data.request_id
      local request = args.data.request
      if request.method == "textDocument/codeAction" then
        if request.type == "pending" then
          -- print(vim.inspect(args))
        elseif request.type == "cancel" then
          -- print(vim.inspect(args))
        elseif request.type == "complete" then
          -- request entry is about to be removed since it is complete
          print(vim.inspect(args))
        end
      end
    end,
  })
end

return M
