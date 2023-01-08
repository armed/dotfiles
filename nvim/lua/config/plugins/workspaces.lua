local M = {
  'natecraddock/workspaces.nvim',
  event = 'VeryLazy',
  dependencies = {
    'nvim-neo-tree/neo-tree.nvim',
    'folke/which-key.nvim'
  }
}

M.session_file = '.nvim_session'

function M.config()
  local ntsm = require('neo-tree.sources.manager')
  local w = require('workspaces')
  local wk = require('which-key')

  vim.g.ssop = 'sesdir,winsize,buffers,tabpages'

  local function session_exists()
    return vim.fn.filewritable(M.session_file) == 1
  end

  local function save_session()
    ntsm.close_all()
    vim.cmd('mksession! ' .. M.session_file)
  end

  local function load_workspace()
    if session_exists() then
      vim.cmd('so ' .. M.session_file)
      ntsm.show('filesystem')
    end
  end

  local function add_workspace()
    save_session()
    w.add()
  end

  vim.api.nvim_create_autocmd(
    'VimLeave',
    {
      callback = function()
        if session_exists() then
          save_session()
        end
      end
    }
  )

  w.setup {
    hooks = {
      open_pre = function ()
        vim.lsp.stop_client(vim.lsp.get_active_clients())
        if session_exists then
          save_session()
          vim.cmd('sil %bwipeout!')
        end
      end
    }
  }

  wk.register({
    w = {
      name = 'Workspaces',
      l = { load_workspace, 'Load existing' },
      a = { add_workspace, 'Add' },
      r = { w.remove, 'Remove' },
      f = { w.open, 'List' }
    }
  }, { prefix = '<leader>' })
end

return M
