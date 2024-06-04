local eval = require("conjure.eval")
local extract = require("conjure.extract")

local M = {}

function M.eval(ns, code)
  local client = require("conjure.client")
  local fn = eval["eval-str"]

  client["with-filetype"]("clojure", fn, {
    origin = "custom_command",
    context = ns or "user",
    code = code,
  })
end

function M.conjure_eval(form)
  return M.eval(nil, form)
end

function M.conjure_eval_fn(form)
  return function()
    return M.conjure_eval(form)
  end
end

function M.conjure_word()
  return extract.word().content
end

function M.conjure_form(is_root)
  return (extract.form({ ["root?"] = is_root })).content
end

return M
