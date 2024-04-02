local eval = require("conjure.eval")
local extract = require("conjure.extract")

local M = {}
function M.conjure_eval(form)
  return eval["eval-str"]({ code = form, origin = "custom_command" })
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
