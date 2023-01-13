local M = {
  'Olical/conjure',
  lazy = true,
  branch = 'develop',
  ft = { 'clojure', 'lua' }
}

local function set_repl_winbar()
  if vim.bo.filetype == 'clojure' then
    vim.opt_local.winbar = ("%#winbarseparator#" ..
        "%=" ..
        "%#user.repl.winbar# " ..
        "%{%v:lua.require'config.tools.nrepl-finder'.get_repl_status('no REPL')%}" ..
        "%#user.repl.winbar# " ..
        "%#winbarseparator#")
  end
end

M.config = function()
  vim.g['conjure#mapping#doc_word'] = false
  vim.g['conjure#client#clojure#nrepl#connection#auto_repl#enabled'] = false
  vim.g['conjure#highlight#enabled'] = true
  vim.g['conjure#highlight#timeout'] = 150
  vim.g['conjure#log#wrap'] = true
  vim.g['conjure#log#jump_to_latest#enabled'] = true
  vim.g['conjure#client#clojure#nrepl#eval#raw_out'] = true
  vim.g['conjure#client#clojure#nrepl#test#raw_out'] = true
  vim.g['conjure#client#clojure#nrepl#test#runner'] = 'kaocha'
  vim.g['conjure#log#jump_to_latest#cursor_scroll_position'] = 'bottom'
  vim.g['conjure#log#hud#enabled'] = false


  local grp = vim.api.nvim_create_augroup('conjure_hooks', { clear = true })
  vim.api.nvim_create_autocmd(
    'BufNewFile',
    {
      group = grp,
      pattern = 'conjure-log-*',
      callback = function(event)
        vim.defer_fn(function()
          vim.lsp.for_each_buffer_client(
            event.buf, function(_, client_id)
            vim.lsp.buf_detach_client(event.buf, client_id)
          end)
        end, 1000)
        vim.diagnostic.disable(event.buf)
      end
    }
  )

  vim.api.nvim_create_autocmd(
    'BufEnter,WinEnter',
    {
      group = grp,
      pattern = 'conjure-log-*',
      callback = function()
        set_repl_winbar()
      end
    }
  )

  local function connect_cmd()
    vim.api.nvim_feedkeys(':ConjureConnect localhost:', 'n', false)
  end

  local mappings = require 'config.plugins.conjure.portal-mappings'
  local wk = require 'which-key'
  local repl = require 'config.tools.nrepl-finder'

  wk.register(mappings, { prefix = '<localleader>' })
  wk.register({
    f = {
      name = 'nREPL files',
      cond = function()
        return vim.bo.filetype == 'clojure'
      end,
      s = { repl.find_repls, 'Find REPLs' },
    },
    c = {
      name = 'Connect',
      cond = function()
        return vim.bo.filetype == 'clojure'
      end,
      c = { connect_cmd, 'Connect to specific port' }
    },
    g = { name = 'Go to' },
    e = {
      name = 'Evaluate',
      c = { name = 'To comment' }
    },
    r = { name = 'Refresh' },
    s = { name = 'Session' },
    t = { name = 'Tests' },
    v = { name = 'Display' }
  }, { prefix = '<localleader>' })
end

return M
