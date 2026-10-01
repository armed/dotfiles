for _, pattern in ipairs({
  "init.lua",
  "lua/**/*.lua",
  "lsp/*.lua",
  "ftplugin/*.lua",
  "tests/*.lua",
}) do
  for _, file in ipairs(vim.fn.glob(pattern, false, true)) do
    assert(loadfile(file))
  end
end
print("PASS: Lua syntax")
