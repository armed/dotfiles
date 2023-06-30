local utils = require("config.plugins.lsp.utils")

local function get_workspace_edit(client, old_name, new_name)
  local will_rename_params = {
    files = {
      {
        oldUri = "file://" .. old_name,
        newUri = "file://" .. new_name,
      },
    },
  }
  print("PARAMS " .. vim.inspect(will_rename_params))
  -- TODO get timeout from config
  local resp =
    client.request_sync("workspace/willRenameFiles", will_rename_params, 1000)
  print("LSPRESULT " .. vim.inspect(resp))
  return resp.result
end

local M = {}

function M.setup()
  vim.api.nvim_create_autocmd("User", {
    pattern = "MiniFilesActionRename",
    callback = function(event)
      local data = event.data
      if data.action == "rename" then
        print(vim.inspect(data))
        for _, client in pairs(vim.lsp.get_active_clients()) do
          local _, will_rename = pcall(function()
            local wr =
              client.server_capabilities.workspace.fileOperations.willRename
            return wr
          end)
          print("WR " .. vim.inspect(will_rename))
          if will_rename ~= nil then
            local filters = will_rename.filters or {}
            print("FILTERS " .. vim.inspect(filters))
            if utils.matches_filters(filters, data.from) then
              local edit = get_workspace_edit(client, data.from, data.to)
              print("EDIT " .. vim.inspect(edit))
              if edit ~= nil then
                vim.lsp.util.apply_workspace_edit(edit, client.offset_encoding)
              end
            end
          end
        end
      end
    end,
  })
end

return M
