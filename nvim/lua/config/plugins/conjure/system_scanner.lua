local utils = require("config.common.utils")
local NuiMenu = require("nui.menu")
local NuiLine = require("nui.line")
local NuiText = require("nui.text")
local event = require("nui.utils.autocmd").event

local M = {}

local cache = {}
local last_used_namespace = {}

local function find_git_root()
  local name = vim.api.nvim_buf_get_name(0)
  local start = name ~= "" and vim.fs.dirname(name) or vim.fn.getcwd()
  return utils.find_furthest_root({ ".git" })(start)
end

-- Read symbols from syntax nodes: metadata and underscores are part of valid Clojure.
function M.parse_system(content)
  local parser = vim.treesitter.get_string_parser(content, "clojure")
  local root = parser:parse()[1]:root()
  local result = { functions = {} }
  for node in root:iter_children() do
    if node:type() == "list_lit" then
      local head, name = node:named_child(0), node:named_child(1)
      if
        head
        and name
        and head:type() == "sym_lit"
        and name:type() == "sym_lit"
      then
        local symbol = name:field("name")[1]
        local form = vim.treesitter.get_node_text(head, content)
        if symbol then
          local value = vim.treesitter.get_node_text(symbol, content)
          if form == "ns" then
            result.namespace = value
          elseif form == "defn" or form == "defn-" then
            result.functions[value] = true
          end
        end
      end
    end
  end
  return result
end

local function scan_system_files_with_rg(git_root, callback)
  if vim.fn.executable("rg") ~= 1 then
    vim.notify("ripgrep (rg) not found", vim.log.levels.WARN)
    callback({})
    return
  end
  vim.system(
    { "rg", "--files", "-0", "-g", "**/system.clj", git_root },
    { text = true, timeout = 10000 },
    function(result)
      vim.schedule(function()
        local systems = {}
        if result.code ~= 0 and result.code ~= 1 then
          vim.notify(
            "System scan failed: " .. (result.stderr or ""),
            vim.log.levels.WARN
          )
        else
          for _, file in
            ipairs(vim.split(result.stdout or "", "\0", { trimempty = true }))
          do
            local ok, lines = pcall(vim.fn.readfile, file)
            if ok then
              local parsed, system =
                pcall(M.parse_system, table.concat(lines, "\n"))
              if parsed and system.namespace then
                table.insert(systems, system)
              elseif not parsed then
                vim.notify(
                  "System scan requires the Clojure parser: "
                    .. tostring(system),
                  vim.log.levels.WARN
                )
              end
            end
          end
        end
        callback(systems)
      end)
    end
  )
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

local function create_namespace_menu(git_root, title, namespaces, callback)
  local menu_items = {}

  local nsps = namespaces
  table.sort(nsps)

  local last_ns = last_used_namespace[git_root]
  local default_index = 1

  for i, ns in ipairs(nsps) do
    table.insert(menu_items, NuiMenu.item(ns))
    if last_ns and ns == last_ns then
      default_index = i
    end
  end

  if #menu_items == 0 then
    vim.notify("No matching system.clj functions found", vim.log.levels.INFO)
    return
  end

  local title_hl = "Normal"
  if title and title:lower():find("restart") then
    title_hl = "ClojureSystemRestart"
  elseif title and title:lower():find("stop") then
    title_hl = "ClojureSystemStop"
  end

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
      last_used_namespace[git_root] = item.text
      callback(item.text)
    end,
  })

  menu:mount()

  if default_index > 1 then
    vim.schedule(function()
      vim.api.nvim_win_set_cursor(menu.winid, { default_index, 0 })
    end)
  end

  menu:on(event.BufLeave, function()
    menu:unmount()
  end)
end

local function show_system_namespaces(title, action, callback)
  local git_root = find_git_root()
  if not git_root then
    vim.notify("Not in a git repository", vim.log.levels.ERROR)
    return
  end

  get_valid_namespaces(git_root, function(systems)
    local namespaces, seen = {}, {}
    for _, system in ipairs(systems) do
      local f = system.functions
      local matches = action == "stop" and f["stop!"]
        or action == "restart" and f["start!"] and f["restart!"]
      if matches and not seen[system.namespace] then
        seen[system.namespace] = true
        table.insert(namespaces, system.namespace)
      end
    end
    create_namespace_menu(git_root, title, namespaces, callback)
  end)
end

function M.open_restart_menu()
  show_system_namespaces("System restart!", "restart", function(namespace)
    local u = require("config.plugins.conjure.util")
    u.eval("user", "((requiring-resolve '" .. namespace .. "/restart!))")
  end)
end

function M.open_stop_menu()
  show_system_namespaces("System stop!", "stop", function(namespace)
    local u = require("config.plugins.conjure.util")
    u.eval("user", "((requiring-resolve '" .. namespace .. "/stop!))")
  end)
end

return M
