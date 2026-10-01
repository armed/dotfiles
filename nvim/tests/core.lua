dofile("tests/bootstrap.lua")
local comment = require("config.basics.comment")
comment.setup()
local function lines(input)
  vim.api.nvim_buf_set_lines(0, 0, -1, false, input)
end
lines({ "// step 1) restart service" })
vim.api.nvim_exec_autocmds("TextChanged", { buffer = 0 })
assert(
  vim.api.nvim_buf_get_lines(0, 0, -1, false)[1] == "// step 1) restart service"
)
lines({ '; (str ")"))' })
comment.split_closers(0, 1, 1)
assert(
  vim.deep_equal(
    vim.api.nvim_buf_get_lines(0, 0, -1, false),
    { '; (str ")")', ")" }
  )
)
lines({ "; (f", "; \\))" })
comment.split_closers(0, 1, 2)
assert(vim.api.nvim_buf_line_count(0) == 2)
lines({ '; (str "first', '; ) second"))' })
comment.split_closers(0, 1, 2)
assert(vim.deep_equal(vim.api.nvim_buf_get_lines(0, 0, -1, false), {
  '; (str "first',
  '; ) second")',
  ")",
}))
lines({ "; (broken])" })
assert(not pcall(comment.split_closers, 0, 1, 1))
assert(vim.api.nvim_buf_get_lines(0, 0, -1, false)[1] == "; (broken])")
local rename = vim.lsp.handlers["textDocument/rename"]
require("config.lsp")
assert(vim.lsp.handlers["textDocument/rename"] == rename)
print(
  "PASS: comments remain unchanged, explicit splits respect literals, native rename handler retained"
)
local diagnostic = require("config.lsp.diagnostics")
local bufa = vim.api.nvim_get_current_buf()
diagnostic.toggle_virtual_line(true)
local option = vim.diagnostic.config().virtual_lines
assert(option(0, bufa).current_line == true)
local bufb = vim.api.nvim_create_buf(true, false)
assert(option(0, bufb) == false)
diagnostic.turn_off_virtual_lines({ buf = bufa })
assert(option(0, bufa) == false)
assert(vim.diagnostic.config().virtual_lines == option)
print("PASS: diagnostic visibility is isolated per buffer")
