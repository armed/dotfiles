local Path = require("plenary").path

local M = {}

local function exists(root, files)
  for _, file in ipairs(files) do
    if vim.fn.filereadable(root .. file) == 1 then
      return true
    end
  end
  return false
end

local nearest_parent = { "/shadow-cljs.edn" }
local farthest_parent = {
  "/deps.edn",
  "/project.clj",
  "/bb.edn",
}
-- This function will return the farthest parent directory containing
-- a `deps.edn`, `project.clj`, `bb.edn` file, or the nearest parent directory
-- containing a `shadow-cljs.edn` file, starting from the given directory.
local function find_optimal_parent(dir)
  if exists(dir, nearest_parent) then
    return dir
  elseif dir == "/" then
    if exists(dir, farthest_parent) then
      return dir
    else
      -- fallback
      return vim.fn.getcwd()
    end
  else
    local parentDir = dir:match("(.*)/")
    if parentDir then
      return find_optimal_parent(parentDir)
    else
      -- fallback
      return vim.fn.getcwd()
    end
  end
end

function M.get_lsp_cwd(file_path)
  local dir = vim.fn.expand(file_path .. ":p:h")
  local parent = find_optimal_parent(dir)
  return parent
end
function M.get_nested_path(tbl, ...)
  local arg = { ... }
  for _, v in ipairs(arg) do
    if tbl[v] then
      tbl = tbl[v]
    else
      return nil
    end
  end
  return tbl
end

-- needed for globs like `**/`
local ensure_dir_trailing_slash = function(path, is_dir)
  if is_dir and not path:match("/$") then
    return path .. "/"
  end
  return path
end

local get_absolute_path = function(name)
  local path = Path:new(name)
  local is_dir = path:is_dir()
  local absolute_path = ensure_dir_trailing_slash(path:absolute(), is_dir)
  return absolute_path, is_dir
end

local get_regex = function(pattern)
  local regex = vim.fn.glob2regpat(pattern.glob)
  if pattern.options and pattern.options.ignorecase then
    return "\\c" .. regex
  end
  return regex
end

-- filter: FileOperationFilter
local match_filter = function(filter, name, is_dir)
  local pattern = filter.pattern
  local match_type = pattern.matches
  if
    not match_type
    or (match_type == "folder" and is_dir)
    or (match_type == "file" and not is_dir)
  then
    local regex = get_regex(pattern)
    local previous_ignorecase = vim.o.ignorecase
    vim.o.ignorecase = false
    local matched = vim.fn.match(name, regex) ~= -1
    vim.o.ignorecase = previous_ignorecase
    return matched
  end

  return false
end

-- filters: FileOperationFilter[]
function M.matches_filters(filters, name)
  local absolute_path, is_dir = get_absolute_path(name)
  for _, filter in pairs(filters) do
    if match_filter(filter, absolute_path, is_dir) then
      return true
    end
  end
  return false
end

function M.get_lsp_clients(filter)
  local get_clients = vim.lsp.get_clients
  return get_clients(filter)
end

return M
