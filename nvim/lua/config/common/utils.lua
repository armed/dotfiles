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

local function parse_s_path_output(raw_paths)
  local paths = vim.split(raw_paths, ":")

  local jar_paths = vim.tbl_filter(function(line)
    if not line or line == "" then
      return false
    end
    if not string.find(line, ".jar") then
      return false
    end
    return true
  end, paths)

  return jar_paths
end

local function is_file_empty(file_path)
  local file = io.open(file_path, "r")
  if not file then
    return true
  end

  local size = file:seek("end")
  file:close()

  return size == 0
end

function M.find_third_party_libs(project_root, callback)
  if vim.fn.executable("clojure") ~= 1 then
    return callback({})
  end

  local deps_file = project_root .. "/deps.edn"
  local file_exists = vim.loop.fs_stat(deps_file)
  if not file_exists or is_file_empty(deps_file) then
    return callback({})
  end

  return vim.fn.jobstart({ "clojure", "-Spath" }, {
    on_stdout = function(_, data)
      local libs = parse_s_path_output(data[1])
      callback(libs)
    end,
    on_stderr = function(_, data)
      if data[1] ~= "" then
        callback({})
      end
    end,
    stdout_buffered = true,
    stderr_buffered = true,
    cwd = project_root,
  })
end

local home_dir = os.getenv("HOME")
local mise_installs = home_dir .. "/.local/share/mise/installs"
local mise_shims = home_dir .. "/.local/share/mise/shims"

function M.mise_install_path(path)
  return mise_installs .. path
end

function M.mise_shim_path(path)
  return mise_shims .. path
end

return M
