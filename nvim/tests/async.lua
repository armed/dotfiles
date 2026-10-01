dofile("tests/bootstrap.lua")
local original_system = vim.system
local original_executable = vim.fn.executable
vim.fn.executable = function()
  return 1
end
local root = vim.fn.tempname()
vim.fn.mkdir(root .. "/project with spaces", "p")
vim.fn.writefile({ "{}" }, root .. "/deps.edn")
vim.fn.writefile({ "12345" }, root .. "/project with spaces/.nrepl-port")
local commands, completions = {}, {}
vim.system = function(command, opts, callback)
  commands[#commands + 1] = { command = command, opts = opts }
  completions[#completions + 1] = callback
  return {}
end
local calls, libs = 0
require("config.common.utils").find_third_party_libs(root, function(value)
  calls = calls + 1
  libs = value
end)
assert(calls == 0 and commands[1].opts.timeout == 30000)
completions[1]({
  code = 0,
  stdout = "/a.jar:/src:/b.jar\n",
  stderr = "JVM warning",
})
assert(vim.wait(100, function()
  return calls == 1
end))
assert(vim.deep_equal(libs, { "/a.jar", "/b.jar" }))
local repl = require("config.tools.nrepl")
local found
repl.find_nrepl_processes(function(value)
  found = value
end)
completions[2]({
  code = 0,
  stdout = " 123 java nrepl.cmdline\n 456 unrelated\n",
})
assert(vim.wait(100, function()
  return #commands == 3
end))
assert(commands[3].command[4] == "123" and commands[3].command[7] == "-Fn")
completions[3]({
  code = 0,
  stdout = "p123\nn" .. root .. "/project with spaces\n",
})
assert(vim.wait(100, function()
  return found ~= nil
end))
assert(
  #found == 1
    and found[1].port == 12345
    and found[1].dir == root .. "/project with spaces"
)
assert(found[1].port_file_path == found[1].dir .. "/.nrepl-port")
vim.system = original_system
vim.fn.executable = original_executable
vim.fn.delete(root, "rf")
print("PASS: asynchronous classpath completion and REPL paths with spaces")
