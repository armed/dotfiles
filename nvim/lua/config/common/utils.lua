local M = {}

function M.glob_exists_in_dir(dir, globs)
  for _, glob in ipairs(globs) do
    if
      #vim.fn.glob(
        vim.api.nvim_call_function("fnamemodify", { dir, ":p" }) .. "/" .. glob
      ) > 0
    then
      return true
    end
  end
  return false
end

function M.find_furthest_root(globs)
  local home = vim.fn.expand("~")

  local function traverse(path, root)
    if path == home or path == "/" then
      return root
    end

    local next = vim.fn.fnamemodify(path, ":h")

    if M.glob_exists_in_dir(path, globs) then
      return traverse(next, path)
    end

    return traverse(next, root)
  end

  return function(start_path)
    local result = string.match(start_path, "^%w+://")
    if result then
      return nil
    end

    local furthest_root = traverse(start_path, nil)
    if furthest_root then
      return furthest_root
    end
    return vim.fn.getcwd()
  end
end

function M.find_file_by_glob(dir, glob)
  local files = vim.fn.globpath(dir, glob, 0, 1)
  if #files > 0 then
    return files[1]
  else
    return nil
  end
end

function M.find_third_party_libs(project_root, callback)
  local deps_file = project_root .. "/deps.edn"
  local stat = vim.uv.fs_stat(deps_file)
  if vim.fn.executable("clojure") ~= 1 or not stat or stat.size == 0 then
    return callback({})
  end
  return vim.system({ "clojure", "-Spath" }, {
    cwd = project_root,
    text = true,
    timeout = 30000,
  }, function(result)
    vim.schedule(function()
      local jars = {}
      if result.code == 0 then
        local separator = vim.fn.has("win32") == 1 and ";" or ":"
        for _, path in
          ipairs(vim.split(vim.trim(result.stdout or ""), separator))
        do
          if path:match("%.jar$") then
            table.insert(jars, path)
          end
        end
      else
        vim.notify(
          "Java classpath: clojure -Spath failed in " .. project_root,
          vim.log.levels.WARN
        )
      end
      callback(jars)
    end)
  end)
end

M.home_dir = vim.fn.expand("~")
M.mise_installs = M.home_dir .. "/.local/share/mise/installs"
M.mise_shims = M.home_dir .. "/.local/share/mise/shims"

function M.mise_install_path(path)
  return M.mise_installs .. path
end

function M.mise_shim_path(path)
  return M.mise_shims .. path
end

return M
