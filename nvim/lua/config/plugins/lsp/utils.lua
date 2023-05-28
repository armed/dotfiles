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

return M
