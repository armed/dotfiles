local win_opts = require('config.plugins.lsp.win_opts')
local tb = require('telescope.builtin')

local function diag_next()
  vim.diagnostic.goto_next(win_opts)
end

local function diag_prev()
  vim.diagnostic.goto_prev(win_opts)
end

local function diag_float()
  vim.diagnostic.open_float(win_opts.float_opts)
end

local M = {}

function M.setup(bufnr)
  return {
    g = {
      d = { tb.lsp_definitions, 'Go to definition' },
      r = { tb.lsp_references, 'LSP rerefences' },
      t = { tb.lsp_type_definitions, 'Type definition' }
    },
    ['<leader>'] = {
      l = {
        r = { vim.lsp.buf.rename, 'Rename' },
        n = { diag_next, 'Next diagnostics' },
        N = { diag_prev, 'Prev diagnostics' },
        l = { diag_float, 'Line diagnostic' },
        a = { vim.lsp.buf.code_action, 'Code actions' },
        s = { tb.lsp_document_symbols, 'Document symbols' },
        S = { tb.lsp_dynamic_workspace_symbols, 'Workspace symbols' },
        f = { vim.lsp.buf.format, 'Format buffer' },
        d = { function() tb.diagnostics { bufnr = bufnr } end, 'Document diagnostics' },
        D = { tb.diagnostics, 'Workspace diagnostics' },
        w = {
          name = 'LSP Workspace',
          a = { vim.lsp.buf.add_workspace_folder, 'Workspace Add Folder' },
          r = { vim.lsp.buf.remove_workspace_folder, 'Workspace Remove Folder' }
        }
      }
    },
    K = { vim.lsp.buf.hover, 'Hover doc' },
    -- ['<C-k>'] = { vim.lsp.buf.signature_help, 'Signature Documentation' }
  }
end

return M
