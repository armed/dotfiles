local M = {
  "Olical/conjure",
  lazy = true,
  branch = "develop",
  ft = { "clojure", "lua", "fennel" },
  dependencies = {
    "PaterJason/cmp-conjure",
  },
}

local function set_repl_winbar()
  if vim.bo.filetype == "clojure" then
    vim.opt_local.winbar = (
      "%#winbarseparator#"
      .. "%="
      .. "%#user.repl.winbar# "
      .. "%{%v:lua.require'config.tools.nrepl-finder'.get_repl_status('no REPL')%}"
      .. "%#user.repl.winbar# "
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
  vim.g["conjure#log#wrap"] = true
  vim.g["conjure#log#jump_to_latest#enabled"] = false
  vim.g["conjure#client#clojure#nrepl#eval#raw_out"] = true
  vim.g["conjure#client#clojure#nrepl#test#raw_out"] = true
  vim.g["conjure#client#clojure#nrepl#test#runner"] = "kaocha"
  vim.g["conjure#log#jump_to_latest#cursor_scroll_position"] = "none"
  vim.g["conjure#log#hud#enabled"] = false
  vim.g["conjure#mapping#log_split"] = false
  vim.g["conjure#mapping#log_vsplit"] = false
  vim.g["conjure#mapping#log_toggle"] = false

  local grp = vim.api.nvim_create_augroup("conjure_hooks", { clear = true })
  vim.api.nvim_create_autocmd("BufNewFile", {
    group = grp,
    pattern = "conjure-log-*",
    callback = function(event)
      vim.defer_fn(function()
        vim.lsp.for_each_buffer_client(event.buf, function(_, client_id)
          vim.lsp.buf_detach_client(event.buf, client_id)
        end)
      end, 1000)
      vim.diagnostic.disable(event.buf)
    end,
  })

  vim.api.nvim_create_autocmd("BufEnter,WinEnter", {
    group = grp,
    pattern = "conjure-log-*",
    callback = function()
      set_repl_winbar()
    end,
  })

  local function connect_cmd()
    vim.api.nvim_feedkeys(":ConjureConnect localhost:", "n", false)
  end

  local mappings = require("config.plugins.conjure.portal-mappings")
  local wk = require("which-key")
  local repl = require("config.tools.nrepl-finder")

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
    vim.cmd("wincmd p")
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
    vim.cmd("wincmd p")
  end

  wk.register(mappings, { prefix = "<localleader>" })
  wk.register({
    c = {
      name = "Connect",
      cond = vim.bo.filetype == "clojure",
      n = {
        repl.find_repls,
        "Find REPLs",
      },
      c = { connect_cmd, "Connect to specific port" },
    },
    g = "Go to",
    e = {
      name = "Evaluate",
      c = { name = "To Comment" },
      -- ["["] = "Square Head Wrap List",
      -- ["]"] = "Square Tail Wrap List",
      -- ["{"] = "Curly Head Wrap List",
      -- ["}"] = "Curly Tail Wrap List",
    },
    r = "Refresh",
    s = "Session",
    t = "Tests",
    v = "Display",
    -- ["?"] = "Convolute",
    -- ["@"] = "Splice List",
    -- ["["] = "Square Head Wrap List",
    -- ["]"] = "Square Tail Wrap List",
    -- ["{"] = "Curly Head Wrap List",
    -- ["}"] = "Curly Tail Wrap List",
    -- ["h"] = "Insert at List Head",
    -- ["I"] = "Round Tail Wrap List",
    -- ["i"] = "Round Head Wrap List",
    ["l"] = {
      name = "Conjure Log",
      g = {
        function()
          conjure_log_toggle()
        end,
        "Toggle",
      },
      v = {
        function()
          conjure_log_open(true)
        end,
        "Open VSplit",
      },
      s = {
        function()
          conjure_log_open(false)
        end,
        "Open Split",
      },
    },
    -- ["o"] = "Raise List",
    -- ["O"] = "Raise Element",
    -- ["W"] = "Round Tail Wrap Element",
    -- ["w"] = "Round Head Wrap Element",
  }, { prefix = "<localleader>" })
end

return M
