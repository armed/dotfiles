-- local Path = require("plenary").path

local M = {}

M.home_dir = os.getenv("HOME")
M.mise_installs = M.home_dir .. "/.local/share/mise/installs"
M.mise_shims = M.home_dir .. "/.local/share/mise/shims"

local function exists(root, files)
  for _, file in ipairs(files) do
    if vim.fn.filereadable(root .. file) == 1 then
      return true
    end
  end
  return false
end

local function find_optimal_parent(dir, markers, farthest_found)
  if exists(dir, markers) then
    farthest_found = dir
  end

  if dir == "/" or dir == "" then
    return farthest_found or vim.fn.getcwd()
  end

  local parent_dir = dir:match("(.*)/") or "/"
  return find_optimal_parent(parent_dir, markers, farthest_found)
end

function M.make_lsp_root_finder(markers)
  return function(bufnr, cb)
    local file_path = vim.api.nvim_buf_get_name(bufnr)
    local dir = vim.fn.expand(file_path .. ":p:h")
    local parent = find_optimal_parent(dir, markers)
    cb(parent)
  end
end

-- function M.get_nested_path(tbl, ...)
--   local arg = { ... }
--   for _, v in ipairs(arg) do
--     if tbl[v] then
--       tbl = tbl[v]
--     else
--       return nil
--     end
--   end
--   return tbl
-- end
--
-- -- needed for globs like `**/`
-- local ensure_dir_trailing_slash = function(path, is_dir)
--   if is_dir and not path:match("/$") then
--     return path .. "/"
--   end
--   return path
-- end
--
-- local get_absolute_path = function(name)
--   local path = Path:new(name)
--   local is_dir = path:is_dir()
--   local absolute_path = ensure_dir_trailing_slash(path:absolute(), is_dir)
--   return absolute_path, is_dir
-- end
--
-- local get_regex = function(pattern)
--   local regex = vim.fn.glob2regpat(pattern.glob)
--   if pattern.options and pattern.options.ignorecase then
--     return "\\c" .. regex
--   end
--   return regex
-- end
--
-- -- filter: FileOperationFilter
-- local match_filter = function(filter, name, is_dir)
--   local pattern = filter.pattern
--   local match_type = pattern.matches
--   if
--     not match_type
--     or (match_type == "folder" and is_dir)
--     or (match_type == "file" and not is_dir)
--   then
--     local regex = get_regex(pattern)
--     local previous_ignorecase = vim.o.ignorecase
--     vim.o.ignorecase = false
--     local matched = vim.fn.match(name, regex) ~= -1
--     vim.o.ignorecase = previous_ignorecase
--     return matched
--   end
--
--   return false
-- end
--
-- -- filters: FileOperationFilter[]
-- function M.matches_filters(filters, name)
--   local absolute_path, is_dir = get_absolute_path(name)
--   for _, filter in pairs(filters) do
--     if match_filter(filter, absolute_path, is_dir) then
--       return true
--     end
--   end
--   return false
-- end

function M.get_lsp_clients(filter)
  local get_clients = vim.lsp.get_clients
  return get_clients(filter)
end

return M
