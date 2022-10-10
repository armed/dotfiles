local M = {}

function M.setup()
  local wk = require("which-key")
  local tree = require("nvim-tree")
  local session = require("session_manager")
  local auto_save = require("auto-save")

  local session_group = vim.api.nvim_create_augroup("SessionGroup", {})
  vim.api.nvim_create_autocmd(
    { "User" },
    {
      pattern = {
        "SessionLoadPre",
        "SessionSavePre"
      },
      group = session_group,
      callback = function()
        auto_save.save()
        return auto_save.off()
      end
    }
  )

  vim.api.nvim_create_autocmd(
    { "User" },
    {
      pattern = { "SessionSavePost" },
      group = session_group,
      callback = function()
        return tree.open()
      end
    })

  vim.api.nvim_create_autocmd(
    { "User" },
    {
      pattern = { "SessionLoadPost" },
      group = session_group,
      callback = function()
        auto_save.on()
        return tree.open()
      end
    })

  wk.register(
    {
      S = {
        name = "Session",
        s = { session.save_current_session, "Save" },
        f = { session.load_session, "Load" },
        d = { session.delete_session, "Delete" }
      }
    },
    { prefix = "<leader>" }
  )
end

return M
