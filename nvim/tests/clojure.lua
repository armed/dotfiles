dofile("tests/bootstrap.lua")
vim.opt.rtp:prepend(vim.fn.stdpath("data") .. "/site")
vim.opt.rtp:prepend(vim.fn.stdpath("data") .. "/lazy/nui.nvim")
vim.opt.rtp:prepend(vim.fn.stdpath("data") .. "/lazy/LuaSnip")
local scanner = require("config.plugins.conjure.system_scanner")
local content = string.rep("; header\n", 15)
  .. '(ns ^{:doc "test"} demo.my_system)\n(defn ^:private start! [] nil)\n(defn restart! [] nil)\n; (defn stop! [] nil)'
local system = scanner.parse_system(content)
assert(system.namespace == "demo.my_system")
assert(system.functions["restart!"] and not system.functions["stop!"])
assert(
  scanner.parse_system("(ns stop_only) (defn stop! [] nil)").functions["stop!"]
)
local captured
package.loaded["conjure.eval"] = {
  ["eval-str"] = function(opts)
    captured = opts
  end,
}
package.loaded["conjure.extract"] =
  { word = function() end, form = function() end }
package.loaded["conjure.client"] = {
  ["with-filetype"] = function(_, fn, opts)
    fn(opts)
  end,
}
local util = require("config.plugins.conjure.util")
util.conjure_eval("(tap> x)")
assert(captured.context == nil)
util.conjure_eval_fn("(open)", "user")()
assert(captured.context == "user")
assert(util.conjure_word() == nil and util.conjure_form(true) == nil)
local repl = require("config.tools.nrepl")
assert(not package.loaded["telescope.pickers"])
assert(repl.parse_connection("localhost:1234").port == 1234)
assert(repl.parse_connection("[::1]:1234").host == "::1")
for _, s in ipairs({ "localhost:", "a:0", "a:65536", "a:x", "a:12 trailing" }) do
  assert(repl.parse_connection(s) == nil)
end
require("luasnip.loaders.from_snipmate").load({
  paths = { vim.fn.getcwd() .. "/snippets" },
})
local snippets = {}
for _, s in ipairs(require("luasnip").get_snippets("clojure")) do
  local doc = s:get_docstring()
  snippets[s.trigger] = type(doc) == "table" and table.concat(doc, "\n") or doc
end
assert(
  snippets["if-let"] and not snippets["if"]:find("snippet if-let", 1, true)
)
for _, trigger in ipairs({
  "defm",
  "defma",
  "letfn",
  "imp",
  "require",
  "if-let",
}) do
  local doc = snippets[trigger]
  doc = doc
    :gsub("%${%d+:([^}]+)}", "%1")
    :gsub("%${%d+}", "nil")
    :gsub("%$%d+", "nil")
  -- Check the exact loader output, including placeholders, is balanced syntax.
  local parser = vim.treesitter.get_string_parser(doc, "clojure")
  assert(not parser:parse()[1]:root():has_error(), trigger .. ": " .. doc)
end
print(
  "PASS: system symbols, namespace context, REPL validation and snippet loader"
)
