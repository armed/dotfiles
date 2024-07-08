local eval = require("conjure.eval")
local extract = require("conjure.extract")
local u = require("config.plugins.conjure.util")

local portal_cmds
local function tap_word()
  local word = u.conjure_word()
  return u.conjure_eval(("(tap> " .. word .. ")"))
end

local function tap_form()
  local form = u.conjure_form(false)
  return u.conjure_eval(("(tap> " .. form .. ")"))
end

local function tap_root_form()
  local form = u.conjure_form(true)
  return u.conjure_eval(("(tap> " .. form .. ")"))
end

portal_cmds = {
  open = u.conjure_eval_fn([[
    (do (ns user)
        ((requiring-resolve 'portal.api/close))
        (def portal ((requiring-resolve 'portal.api/open)
                     {:theme :portal.colors/nord}))
        (add-tap (requiring-resolve 'portal.api/submit)))
  ]]),
  clear = u.conjure_eval_fn("(portal.api/clear)"),
  last_exception = u.conjure_eval_fn("(tap> (Throwable->map *e))"),
  tap_word = tap_word,
  tap_form = tap_form,
  tap_root_form = tap_root_form,
}

return {
  s = {
    cond = function()
      return vim.bo.filetype == "clojure"
    end,
    o = { ":ConjureOutSubscribe<cr>", "Subscribe to output" },
    O = { ":ConjureOutUnsubscribe<cr>", "Unsubscribe from output" },
  },
  p = {
    cond = function()
      return vim.bo.filetype == "clojure"
    end,
    name = "Portal",
    p = { portal_cmds.open, "Portal open" },
    c = { portal_cmds.clear, "Portal clear" },
    e = { portal_cmds.last_exception, "Tap last exception" },
    w = { portal_cmds.tap_word, "Tap word" },
    f = { portal_cmds.tap_form, "Tap current form" },
    r = { portal_cmds.tap_root_form, "Tap root form" },
  },
}
