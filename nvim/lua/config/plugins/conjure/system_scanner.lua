local utils = require("config.common.utils")
local NuiMenu = require("nui.menu")
local NuiLine = require("nui.line")
local NuiText = require("nui.text")
local event = require("nui.utils.autocmd").event

local M = {}

local cache = {}

local function setup_highlights()
  vim.api.nvim_set_hl(0, "SystemRestart", { fg = "#27F53C", bold = true })
  vim.api.nvim_set_hl(0, "SystemStop", { fg = "#F54927", bold = true })
end

setup_highlights()

local function find_git_root()
  local git_root_finder = utils.find_furthest_root({ ".git" })
  return git_root_finder(vim.fn.getcwd())
end

local function extract_namespace_from_content(content)
  return content:match("%(ns%s+([%w%.%-]+)")
end

local function scan_system_files_with_rg(git_root, callback)
  if vim.fn.executable("rg") ~= 1 then
    vim.notify(
      "ripgrep (rg) not found, falling back to slower method",
      vim.log.levels.WARN
    )
    callback({})
    return
  end

  local cmd = {
    "rg",
    "-l",
    "-g",
    "**/system.clj",
    "--type",
    "clojure",
    "--pcre2",
    "--multiline",
    "(?s)(?=.*^\\(defn start!).*(?<=^\\(defn restart!)",
    git_root,
  }

  local callback_called = false

  vim.fn.jobstart(cmd, {
    on_stdout = function(_, data)
      if callback_called then
        return
      end

      local files_with_functions = {}

      for _, line in ipairs(data) do
        if line and line ~= "" then
          table.insert(files_with_functions, line)
        end
      end

      local namespaces = {}

      for _, file_path in ipairs(files_with_functions) do
        local lines = vim.fn.readfile(file_path, "", 10)
        local content = table.concat(lines, "\n")
        local namespace = extract_namespace_from_content(content)

        if namespace then
          table.insert(namespaces, namespace)
        end
      end

      callback_called = true
      callback(namespaces)
    end,
    on_stderr = function(_, data)
      if callback_called then
        return
      end

      local has_error = false
      for _, line in ipairs(data) do
        if line and line ~= "" then
          has_error = true
          break
        end
      end

      if has_error then
        callback_called = true
        callback({})
      end
    end,
    stdout_buffered = true,
    stderr_buffered = true,
  })
end

local function is_cache_valid(git_root)
  local cached_data = cache[git_root]
  if not cached_data then
    return false
  end

  local cache_age = os.time() - cached_data.scan_time
  return cache_age < 300 -- 5 minutes
end

local function update_cache(git_root, namespaces)
  cache[git_root] = {
    namespaces = namespaces,
    scan_time = os.time(),
  }
end

local function get_valid_namespaces(git_root, callback)
  if is_cache_valid(git_root) then
    callback(cache[git_root].namespaces)
    return
  end

  scan_system_files_with_rg(git_root, function(namespaces)
    update_cache(git_root, namespaces)
    callback(namespaces)
  end)
end

local function create_namespace_menu(title, namespaces, callback)
  local menu_items = {}

  for _, ns in ipairs(namespaces) do
    table.insert(menu_items, NuiMenu.item(ns))
  end

  if #menu_items == 0 then
    vim.notify(
      "No system.clj files with start!/restart! functions found",
      vim.log.levels.INFO
    )
    return
  end

  -- Determine title highlight based on content
  local title_hl = "Normal"
  if title and title:lower():find("restart") then
    title_hl = "SystemScannerRestart"
  elseif title and title:lower():find("stop") then
    title_hl = "SystemScannerStop"
  end

  -- Create styled title using NUI components
  local title_text = NuiText(title or " System Namespaces ", title_hl)
  local title_line = NuiLine({ title_text })

  local menu = NuiMenu({
    position = "50%",
    size = {
      width = 60,
      height = math.min(#menu_items + 4, 20),
    },
    relative = "editor",
    border = {
      style = "rounded",
      text = {
        top = title_line,
        top_align = "center",
      },
    },
    win_options = {
      winhighlight = "Normal:Normal,FloatBorder:Normal",
    },
  }, {
    lines = menu_items,
    keymap = {
      focus_next = { "j", "<Down>", "<Tab>" },
      focus_prev = { "k", "<Up>", "<S-Tab>" },
      close = { "<Esc>", "<C-c>", "q" },
      submit = { "<CR>" },
    },
    on_close = function()
      -- Menu closed
    end,
    on_submit = function(item)
      callback(item.text)
    end,
  })

  menu:mount()

  menu:on(event.BufLeave, function()
    menu:unmount()
  end)
end

local function show_system_namespaces(title, callback)
  local git_root = find_git_root()
  if not git_root then
    vim.notify("Not in a git repository", vim.log.levels.ERROR)
    return
  end

  get_valid_namespaces(git_root, function(namespaces)
    create_namespace_menu(title, namespaces, callback)
  end)
end

---@diagnostic disable-next-line: unused-local
local function clear_cache()
  local git_root = find_git_root()
  if git_root then
    cache[git_root] = nil
    vim.notify("Cache cleared for " .. git_root, vim.log.levels.INFO)
  end
end

---@diagnostic disable-next-line: unused-local
local function clear_all_cache()
  cache = {}
  vim.notify("All cache cleared", vim.log.levels.INFO)
end

function M.open_restart_menu()
  show_system_namespaces("System restart!", function(namespace)
    local u = require("config.plugins.conjure.util")
    u.conjure_eval("(" .. namespace .. "/restart!)")
  end)
end

function M.open_stop_menu()
  show_system_namespaces("System stop!", function(namespace)
    local u = require("config.plugins.conjure.util")
    u.conjure_eval("(" .. namespace .. "/stop!)")
  end)
end

return M
