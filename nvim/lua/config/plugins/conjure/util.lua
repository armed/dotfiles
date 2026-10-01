local eval = require("conjure.eval")
local extract = require("conjure.extract")

local M = {}

function M.eval(ns, code)
  local client = require("conjure.client")
  local fn = eval["eval-str"]

  client["with-filetype"]("clojure", fn, {
    origin = "custom_command",
    context = ns,
    code = code,
  })
end

function M.conjure_eval(form)
  return M.eval(nil, form)
end

function M.conjure_eval_fn(form, ns)
  return function()
    return M.eval(ns, form)
  end
end

function M.conjure_word()
  local word = extract.word()
  return word and word.content
end

function M.conjure_form(is_root)
  local form = extract.form({ ["root?"] = is_root })
  return form and form.content
end

return M
