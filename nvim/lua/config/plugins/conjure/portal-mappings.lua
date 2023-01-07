local eval = require 'conjure.eval'
local extract = require 'conjure.extract'

local function conjure_eval(form)
  return eval["eval-str"]({ code = form, origin = "custom_command" })
end

local function conjure_eval_fn(form)
  return function()
    return conjure_eval(form)
  end
end

local function conjure_word()
  return extract.word().content
end

local function conjure_form(is_root)
  return (extract.form({ ["root?"] = is_root })).content
end

local portal_cmds
local function tap_word()
  local word = conjure_word()
  return conjure_eval(("(tap> " .. word .. ")"))
end

local function tap_form()
  local form = conjure_form(false)
  return conjure_eval(("(tap> " .. form .. ")"))
end

local function tap_root_form()
  local form = conjure_form(true)
  return conjure_eval(("(tap> " .. form .. ")"))
end

portal_cmds = {
  open = conjure_eval_fn([[
    (do (ns dev)
        ((requiring-resolve 'portal.api/close))
        (def portal ((requiring-resolve 'portal.api/open)
                     {:theme :portal.colors/nord}))
        (add-tap (requiring-resolve 'portal.api/submit)))
  ]]),
  clear = conjure_eval_fn("(portal.api/clear)"),
  last_exception = conjure_eval_fn("(tap> (Throwable->map *e))"),
  tap_word = tap_word,
  tap_form = tap_form,
  tap_root_form = tap_root_form
}

return {
  s = {
    cond = function() return vim.bo.filetype == 'clojure' end,
    o = { ":ConjureOutSubscribe<cr>", "Subscribe to output" },
    O = { ":ConjureOutUnsubscribe<cr>", "Unsubscribe from output" }
  },
  p = {
    cond = function() return vim.bo.filetype == 'clojure' end,
    name = "Portal",
    p = { portal_cmds.open, "Portal open" },
    c = { portal_cmds.clear, "Portal clear" },
    e = { portal_cmds.last_exception, "Tap last exception" },
    w = { portal_cmds.tap_word, "Tap word" },
    f = { portal_cmds.tap_form, "Tap current form" },
    r = { portal_cmds.tap_root_form, "Tap root form" }
  }
}
