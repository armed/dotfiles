local M = {
  "Olical/conjure",
  branch = "main",
  ft = { "clojure", "lua", "fennel", "lisp" },
}

local function set_repl_winbar()
  if vim.bo.filetype == "clojure" then
    vim.opt_local.winbar = (
      "%#winbarseparator#"
      .. "%="
      .. "%#user.repl.winbar# "
      .. "%{%v:lua.require'config.tools.nrepl'.get_repl_status('no REPL')%}"
      .. "%#winbarseparator#"
    )
  end
end

M.config = function()
  vim.g["conjure#filetype#fennel"] = "conjure.client.fennel.stdio"
  vim.g["conjure#mapping#doc_word"] = false
  vim.g["conjure#client#clojure#nrepl#connection#auto_repl#enabled"] = false
  vim.g["conjure#highlight#enabled"] = true
  vim.g["conjure#highlight#timeout"] = 150
  vim.g["conjure#log#wrap"] = false
  vim.g["conjure#log#jump_to_latest#enabled"] = false
  vim.g["conjure#client#clojure#nrepl#eval#raw_out"] = true
  vim.g["conjure#client#clojure#nrepl#test#raw_out"] = true
  -- vim.g["conjure#client#clojure#nrepl#test#runner"] = "kaocha"
  vim.g["conjure#log#jump_to_latest#cursor_scroll_position"] = "none"
  vim.g["conjure#log#hud#enabled"] = false
  vim.g["conjure#client#clojure#nrepl#mapping#refresh_all"] = false
  vim.g["conjure#client#clojure#nrepl#mapping#refresh_changed"] = false
  vim.g["conjure#client#clojure#nrepl#mapping#refresh_clear"] = false
  vim.g["conjure#mapping#log_split"] = false
  vim.g["conjure#mapping#log_vsplit"] = false
  vim.g["conjure#mapping#log_toggle"] = false

  require("conjure.main").main()
  require("conjure.mapping")["on-filetype"]()

  local grp = vim.api.nvim_create_augroup("conjure_hooks", { clear = true })

  vim.api.nvim_create_autocmd("BufNewFile", {
    group = grp,
    pattern = "conjure-log-*",
    callback = function(event)
      vim.diagnostic.enable(false, { bufnr = event.buf })
    end,
  })

  vim.api.nvim_create_autocmd({ "BufEnter", "WinEnter" }, {
    group = grp,
    pattern = "conjure-log-*",
    callback = function(event)
      local utils = require("config.lsp.utils")
      set_repl_winbar()
      for _, client in ipairs(utils.get_lsp_clients({ bufnr = event.buf })) do
        vim.lsp.buf_detach_client(event.buf, client.id)
      end
    end,
  })

  local function connect_cmd()
    vim.api.nvim_feedkeys(":ConjureConnect localhost:", "n", false)
  end

  local mappings = require("config.plugins.conjure.portal-mappings")
  local wk = require("which-key")
  local repl = require("config.tools.nrepl")
  local u = require("config.plugins.conjure.util")

  local function conjure_log_open(is_vertical)
    local log = require("conjure.log")
    log["close-visible"]()
    local cur_log
    if is_vertical then
      log.vsplit()
      cur_log = "vsplit"
    else
      log.split()
      local win = vim.api.nvim_get_current_win()
      vim.api.nvim_win_set_height(win, 10)
      cur_log = "split"
    end
    log["last-open-cmd"] = cur_log
  end

  local function is_log_win_open()
    local l = require("conjure.log")
    local wins = l["aniseed/locals"]["find-windows"]()
    for _, _ in pairs(wins) do
      return true
    end
    return false
  end

  local function conjure_log_toggle()
    local log = require("conjure.log")
    log.toggle()
    if is_log_win_open() and log["last-open-cmd"] == "split" then
      local win = vim.api.nvim_get_current_win()
      vim.api.nvim_win_set_height(win, 10)
    end
  end

  wk.add(mappings)
  wk.add({
    {
      "<localleader>R",
      function()
        u.conjure_eval("(user/reset-app!)")
      end,
      desc = "Reset",
    },
    {
      "<localleader>S",
      function()
        u.conjure_eval("(user/stop-app!)")
      end,
      desc = "Stop",
    },
    { "<localleader>c", group = "Connect" },
    { "<localleader>cc", connect_cmd, desc = "Connect to specific port" },
    { "<localleader>cn", repl.find_repls, desc = "Find REPLs" },
    { "<localleader>e", group = "Evaluate" },
    { "<localleader>ec", group = "To Comment" },
    { "<localleader>g", desc = "Go to" },
    { "<localleader>l", group = "Conjure Log" },
    {
      "<localleader>lg",
      function()
        conjure_log_toggle()
      end,
      desc = "Toggle",
    },
    {
      "<localleader>ls",
      function()
        conjure_log_open(false)
      end,
      desc = "Open Split",
    },
    {
      "<localleader>lv",
      function()
        conjure_log_open(true)
      end,
      desc = "Open VSplit",
    },
    {
      "<localleader>r",
      function()
        vim.cmd("wa")
        u.conjure_eval("((requiring-resolve 'clj-reload.core/reload))")
      end,
      desc = "CLJ Reload",
    },
    { "<localleader>s", desc = "Session" },
    { "<localleader>t", desc = "Tests" },
    { "<localleader>v", desc = "Display" },
  })
end

return M
