local M = { float_opts = { border = 'rounded' } }

local function diag_next()
  vim.diagnostic.goto_next({ float = M.float_opts })
end

local function diag_prev()
  vim.diagnostic.goto_prev({ float = M.float_opts })
end

local function diag_float()
  vim.diagnostic.open_float(M.float_opts)
end

M.bindings = {
  g = {
    d = { ':Telescope lsp_definitions<cr>', 'Go to definition' },
    r = { ':Telescope lsp_references<cr>', 'LSP rerefences' },
    t = { ':Telescope lsp_type_definitions<cr>', 'Type definition' }
  },
  ['<leader>'] = {
    l = {
      r = { vim.lsp.buf.rename, 'Rename' },
      n = { diag_next, 'Next diagnostics' },
      N = { diag_prev, 'Prev diagnostics' },
      l = { diag_float, 'Line diagnostic' },
      a = { vim.lsp.buf.code_action, 'Code actions' },
      s = { ':Telescope lsp_document_symbols<cr>', 'Document symbols' },
      S = { ':Telescope lsp_workspace_symbols<cr>', 'Workspace symbols' },
      f = { vim.lsp.buf.format, 'Format buffer' },
      d = { ':Telescope diagnostics bufnr=0<cr>', 'Document diagnostics' },
      D = { ':Telescope diagnostics<cr>', 'Workspace diagnostics' },
      w = {
        name = 'LSP Workspace',
        a = { vim.lsp.buf.add_workspace_folder, 'Workspace Add Folder' },
        r = { vim.lsp.buf.remove_workspace_folder, 'Workspace Remove Folder' }
      }
    }
  },
  K = { vim.lsp.buf.hover, 'Hover doc' },
  ['<C-k>'] = { vim.lsp.buf.signature_help, 'Signature Documentation' }
}

return M
