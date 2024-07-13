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
  {
    "<localleader>s",
    group = "Conjure Subscription",
    cond = function()
      return vim.bo.filetype == "clojure"
    end,
  },
  {
    "<localleader>so",
    "<cmd>ConjureOutSubscribe<cr>",
    desc = "Subscribe to output",
  },
  {
    "<localleader>sO",
    "<cmr>ConjureOutUnsubscribe<cr>",
    desc = "Unsubscribe from output",
  },
  {
    "<localleader>p",
    group = "Portal",
    cond = function()
      return vim.bo.filetype == "clojure"
    end,
  },
  {
    "<localleader>pp",
    portal_cmds.open,
    desc = "Portal open",
  },
  {
    "<localleader>pc",
    portal_cmds.clear,
    desc = "Portal clear",
  },
  {
    "<localleader>pe",
    portal_cmds.last_exception,
    desc = "Tap last exception",
  },
  {
    "<localleader>pw",
    portal_cmds.tap_word,
    desc = "Tap word",
  },
  {
    "<localleader>pf",
    portal_cmds.tap_form,
    desc = "Tap current form",
  },
  {
    "<localleader>pr",
    portal_cmds.tap_root_form,
    desc = "Tap root form",
  },
}
