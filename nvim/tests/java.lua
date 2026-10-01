dofile("tests/bootstrap.lua")
local dir = vim.fn.tempname()
local callbacks, configs = {}, {}
local jdt_home = dir .. "/jdtls"
for _, platform in ipairs({ "mac", "mac_arm", "linux", "linux_arm", "win" }) do
  vim.fn.mkdir(jdt_home .. "/config_" .. platform, "p")
end
vim.fn.mkdir(jdt_home .. "/plugins", "p")
vim.fn.writefile(
  {},
  jdt_home .. "/plugins/org.eclipse.equinox.launcher_test.jar"
)
vim.g.jdtls_home = jdt_home
vim.g.jdtls_java = vim.fn.exepath("nvim")
for _, project in ipairs({ "java-a", "java-b" }) do
  vim.fn.mkdir(dir .. "/" .. project, "p")
  vim.fn.writefile({ "<project/>" }, dir .. "/" .. project .. "/pom.xml")
end
package.loaded.jdtls = {
  extendedClientCapabilities = {},
  start_or_attach = function(config)
    configs[#configs + 1] =
      { buf = vim.api.nvim_get_current_buf(), config = config }
  end,
}
require("config.common.utils").find_third_party_libs = function(root, cb)
  callbacks[root] = cb
end
local java = require("config.lsp.custom.jdtls")
local buffers = {}
for _, project in ipairs({ "java-a", "java-b" }) do
  local buf = vim.api.nvim_create_buf(true, false)
  buffers[#buffers + 1] = buf
  vim.api.nvim_buf_set_name(buf, dir .. "/" .. project .. "/Main.java")
  vim.bo[buf].filetype = "java"
  java.start(buf)
end
assert(#configs == 0, "classpath must be asynchronous")
for root, cb in pairs(callbacks) do
  cb({ root .. "/library.jar" })
end
assert(#configs == 2)
assert(configs[1].config.root_dir ~= configs[2].config.root_dir)
assert(
  configs[1].config.cmd[#configs[1].config.cmd]
    ~= configs[2].config.cmd[#configs[2].config.cmd]
)
for _, entry in ipairs(configs) do
  assert(
    vim.api.nvim_buf_get_name(entry.buf):find(entry.config.root_dir, 1, true)
      == 1
  )
  assert(
    entry.config.settings.java.project.referencedLibraries[1]
      == entry.config.root_dir .. "/library.jar"
  )
end
-- Switching or closing a buffer during classpath discovery must not attach it.
local waiting = vim.api.nvim_create_buf(true, false)
vim.fn.mkdir(dir .. "/java-c", "p")
vim.fn.writefile({ "<project/>" }, dir .. "/java-c/pom.xml")
vim.api.nvim_buf_set_name(waiting, dir .. "/java-c/Main.java")
vim.bo[waiting].filetype = "java"
java.start(waiting)
vim.api.nvim_buf_delete(waiting, { force = true })
callbacks[vim.uv.fs_realpath(dir .. "/java-c")]({})
assert(#configs == 2)
vim.fn.delete(dir, "rf")
print("PASS: asynchronous Java roots, workspaces and buffer attachment")
