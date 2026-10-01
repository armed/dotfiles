dofile("tests/bootstrap.lua")
local setup, cwd
package.loaded["nvim-tree"] = {
  setup = function(opts)
    setup = opts
  end,
}
package.loaded["nvim-tree.api"] = {
  config = { mappings = { default_on_attach = function() end } },
  tree = {
    get_node_under_cursor = function()
      return { absolute_path = "/tmp/project with spaces/file.clj" }
    end,
  },
}
package.loaded["which-key"] = { add = function() end }
package.loaded["fzf-lua"] = {
  files = function(opts)
    cwd = opts.cwd
  end,
  grep_project = function(opts)
    cwd = opts.cwd
  end,
}
require("config.plugins.nvim-tree").config()
local buf = vim.api.nvim_get_current_buf()
setup.on_attach(buf)
-- -u NONE uses Vim's default leader.
local find = vim.fn.maparg("\\ef", "n", false, true)
assert(find.buffer == 1 and type(find.callback) == "function")
find.callback()
assert(cwd == "/tmp/project with spaces")
local grep = vim.fn.maparg("\\eg", "n", false, true)
grep.callback()
assert(cwd == "/tmp/project with spaces")
local other = vim.api.nvim_create_buf(true, false)
assert(#vim.api.nvim_buf_get_keymap(other, "n") == 0)
print("PASS: buffer-local tree actions preserve absolute paths with spaces")
