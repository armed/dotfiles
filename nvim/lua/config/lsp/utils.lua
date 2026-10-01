local M = {}
local common = require("config.common.utils")
M.home_dir = common.home_dir
M.mise_installs = common.mise_installs
M.mise_shims = common.mise_shims

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

function M.get_lsp_clients(filter)
  local get_clients = vim.lsp.get_clients
  return get_clients(filter)
end

return M
