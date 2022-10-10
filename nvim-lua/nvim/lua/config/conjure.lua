local M = {}

function M.setup()
  vim.g["conjure#extract#tree_sitter#enabled"] = true
  vim.g["conjure#client#clojure#nrepl#connection#auto_repl#enabled"] = false
  vim.g["conjure#highlight#enabled"] =  true
  vim.g["conjure#highlight#timeout"] =  150
  vim.g["conjure#log#wrap"] =  true
  vim.g["conjure#log#jump_to_latest#enabled"] =  true
  vim.g["conjure#client#clojure#nrepl#eval#raw_out"] =  true
  vim.g["conjure#client#clojure#nrepl#test#raw_out"] =  true
  vim.g["conjure#client#clojure#nrepl#test#runner"] =  "kaocha"
  vim.g["conjure#log#jump_to_latest#cursor_scroll_position"] =  "bottom"

  local eval = require "conjure.eval"
  local extract = require "conjure.extract"

  local function conjure_eval(form)
    eval["eval-str"]({code = form, origin = "custom_command"})
  end

  local function conjure_eval_fn(form)
    return function ()
      conjure_eval(form)
    end
  end

  local function conjure_word()
    extract.word():content()
  end

  local function conjure_form(is_root)
    extract.form({["root?"] = is_root}):content()
  end

  local portal_cmds = {
    open = conjure_eval_fn [[
      (do (ns dev)
          ((requiring-resolve "portal.api/close))
          (def portal ((requiring-resolve "portal.api/open)
                       {:theme :portal.colors/nord}))
          (add-tap (requiring-resolve "portal.api/submit))) 
    ]],

    clear = conjure_eval_fn "(portal.api/clear)",

    last_exception = conjure_eval_fn "(tap> (Throwable->map *e))",

    tap_word = function ()
      local word = conjure_word()
      conjure_eval("(tap>" .. word .. ")")
    end,

    tap_form = function ()
      local form = conjure_form(false)
      conjure_eval("(tap>" .. form .. ")")
    end,

    tap_root_form = function ()
      local form = conjure_form(true)
      conjure_eval("(tap>" .. form .. ")")
    end,
  }

  local llopts = {
    prefix = "<localleader>",
    buffer = 0
  }

  local portal_mappings = {
    p = {
      name = "Portal",
      p = { portal_cmds.open, "Portal open" },
      c = { portal_cmds.clear, "Portal clear" },
      e = { portal_cmds.last_exception, "Portal last exception" },
      w = { portal_cmds.tap_word, "Portal tap word" },
      f = { portal_cmds.tap_form, "Portal tap form" },
      r = { portal_cmds.tap_root_form, "Portal tap root form" },
    }
  }

  vim.api.nvim_create_autocmd("FileType", {
    pattern = { "clojure", "lua", "fennel" },
    callback = function ()
      require("which-key").register(portal_mappings, llopts)
    end
  })
end

return M
