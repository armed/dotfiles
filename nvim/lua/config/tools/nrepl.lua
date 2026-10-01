local M = {}

function M.get_repl_status(not_connected_msg)
  if vim.bo.filetype ~= "clojure" then
    return not_connected_msg
  end
  local ok, state = pcall(require, "conjure.client.clojure.nrepl.state")
  local conn = ok and state.get("conn")
  if not conn or not conn.port then
    return not_connected_msg
  end
  local host = conn.host or "localhost"
  if conn.port_file_path then
    host = vim.fs.basename(vim.fs.dirname(conn.port_file_path))
  end
  return " " .. host .. ":" .. conn.port
end

function M.parse_connection(value)
  local host, port = vim.trim(value):match("^([^:%s]+):(%d+)$")
  if not host then
    host, port = vim.trim(value):match("^%[([^%]%s]+)%]:(%d+)$")
  end
  port = tonumber(port)
  if not host or not port or port < 1 or port > 65535 then
    return nil
  end
  return { host = host, port = port }
end

local function connect(details)
  local host = details.host or "localhost"
  require("conjure.client.clojure.nrepl.server").connect({
    host = host,
    port = details.port,
    port_file_path = details.port_file_path,
    cb = function()
      vim.notify("Connected to nREPL at " .. host .. ":" .. details.port)
    end,
  })
end

local function read_ports(dirs)
  local seen, results = {}, {}
  for _, dir in ipairs(dirs) do
    if not seen[dir] then
      seen[dir] = true
      local file_path = dir .. "/.nrepl-port"
      local file = io.open(file_path, "r")
      if file then
        local raw = vim.trim(file:read("*all"))
        file:close()
        local port = raw:match("^%d+$") and tonumber(raw)
        if port and port >= 1 and port <= 65535 then
          table.insert(
            results,
            { dir = dir, port = port, port_file_path = file_path }
          )
        end
      end
    end
  end
  table.sort(results, function(a, b)
    return a.dir < b.dir
  end)
  return results
end

function M.find_nrepl_processes(callback)
  if vim.fn.executable("ps") ~= 1 or vim.fn.executable("lsof") ~= 1 then
    vim.notify("REPL discovery requires ps and lsof", vim.log.levels.WARN)
    callback({})
    return
  end
  vim.system(
    { "ps", "-axo", "pid=,command=" },
    { text = true, timeout = 10000 },
    function(result)
      vim.schedule(function()
        if result.code ~= 0 then
          vim.notify("Cannot list nREPL processes", vim.log.levels.WARN)
          callback({})
          return
        end
        local pids = {}
        for line in (result.stdout or ""):gmatch("[^\n]+") do
          if line:find("nrepl", 1, true) then
            local pid = line:match("^%s*(%d+)%s+")
            if pid then
              table.insert(pids, pid)
            end
          end
        end
        if #pids == 0 then
          callback({})
          return
        end
        -- -Fn emits the full path, including spaces, without shell or column parsing.
        vim.system(
          { "lsof", "-a", "-p", table.concat(pids, ","), "-d", "cwd", "-Fn" },
          { text = true, timeout = 10000 },
          function(files)
            vim.schedule(function()
              local dirs = {}
              for line in (files.stdout or ""):gmatch("[^\n]+") do
                if line:sub(1, 1) == "n" then
                  table.insert(dirs, line:sub(2))
                end
              end
              callback(read_ports(dirs))
            end)
          end
        )
      end)
    end
  )
end

function M.find_repls()
  M.find_nrepl_processes(function(results)
    local action_state = require("telescope.actions.state")
    local actions = require("telescope.actions")
    local pickers = require("telescope.pickers")
    local finders = require("telescope.finders")
    local opts = require("telescope.themes").get_dropdown({})
    pickers
      .new(opts, {
        prompt_title = "Find REPLs",
        sorter = require("telescope.config").values.generic_sorter(opts),
        finder = finders.new_table({
          results = results,
          entry_maker = function(entry)
            return {
              value = entry,
              display = entry.dir .. " :: " .. entry.port,
              ordinal = entry.dir,
            }
          end,
        }),
        attach_mappings = function(prompt_bufnr)
          actions.select_default:replace(function()
            local selection = action_state.get_selected_entry()
            actions.close(prompt_bufnr)
            if selection then
              connect(selection.value)
            end
          end)
          return true
        end,
      })
      :find()
  end)
end

function M.direct_connect()
  vim.ui.input(
    { prompt = "nREPL host:port: ", default = "localhost:" },
    function(value)
      if value == nil then
        return
      end
      local details = M.parse_connection(value)
      if not details then
        vim.notify(
          "Enter host:port with a port between 1 and 65535",
          vim.log.levels.WARN
        )
        return
      end
      connect(details)
    end
  )
end

return M
