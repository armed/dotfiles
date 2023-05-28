local actions = require("telescope.actions")
local action_state = require("telescope.actions.state")

local M = {}

local function app_name_from_path(path)
  local folder_name = nil
  if path ~= nil and path ~= "" then
    -- reverse the string to make the search easier
    local reversed_path = path:reverse()
    -- find the first and second slash from the end
    local first_slash = reversed_path:find("/")
    local second_slash = reversed_path:find("/", first_slash + 1)
    -- extract the folder name between the two slashes
    folder_name = reversed_path:sub(first_slash + 1, second_slash - 1)
    -- reverse the folder name back to normal
    folder_name = folder_name:reverse()
    -- special case for ".shadow-cljs"
    if folder_name == ".shadow-cljs" then
      -- find the third slash
      local third_slash = reversed_path:find("/", second_slash + 1)
      if third_slash then
        -- extract the folder name between the second and third slashes
        folder_name = reversed_path:sub(second_slash + 1, third_slash - 1)
        -- reverse the folder name back to normal
        folder_name = folder_name:reverse() .. "[shadow.cljs]"
      end
      folder_name = "local[shadow.cljs]"
    end
  end
  return folder_name
end

function M.get_repl_status(not_connected_msg)
  if vim.bo.filetype == "clojure" then
    local ok, nrepl_state = pcall(require, "conjure.client.clojure.nrepl.state")
    if ok then
      local conn = nrepl_state.get("conn")
      if conn then
        local host = conn.host
        local port = conn.port
        local port_file_path = conn.port_file_path
        if port then
          if port_file_path then
            if
              port_file_path == ".nrepl-port"
              or port_file_path == "nrepl.port"
            then
              port_file_path = vim.fn.getcwd() .. "/" .. port_file_path
            end
            local app = app_name_from_path(port_file_path)
            return " " .. (app or "local") .. ":" .. port
          end
          return host .. ":" .. port
        end
      end
    end
  end
  return not_connected_msg
end

local function run_selection(prompt_bufnr)
  actions.select_default:replace(function()
    local nrepl_server = require("conjure.client.clojure.nrepl.server")
    actions.close(prompt_bufnr)
    local selection = action_state.get_selected_entry()
    local port = io.lines(selection.path)()
    nrepl_server.connect({
      host = "localhost",
      port = port,
      port_file_path = selection.path,
      cb = function()
        print("connected")
      end,
    })
  end)
  return true
end

local find_opts = require("telescope.themes").get_dropdown({
  borderchars = {
    { "─", "│", "─", "│", "┌", "┐", "┘", "└" },
    prompt = { "─", "│", " ", "│", "┌", "┐", "│", "│" },
    results = { "─", "│", "─", "│", "├", "┤", "┘", "└" },
    preview = { "─", "│", "─", "│", "┌", "┐", "┘", "└" },
  },
  width = 0.8,
  previewer = false,
  prompt_title = "REPLs",
  cwd = "~/Developer/k16",
  find_command = {
    "rg",
    "--files",
    "--no-ignore",
    "--with-filename",
    "--hidden",
    "-g",
    "!.joyride",
    "-g",
    "!node_modules",
    "-g",
    "!target",
    "-g",
    "!classes",
    "-g",
    ".nrepl-port",
    "-g",
    "nrepl.port",
  },
  attach_mappings = run_selection,
})

function M.find_repls()
  require("telescope.builtin").find_files(find_opts)
end

return M
