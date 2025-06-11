local function opened_on_boot()
  for i = 1, #vim.v.argv do
    if
      vim.v.argv[i] == "-c"
      and vim.v.argv[i + 1]
      and vim.v.argv[i + 1]:match("^Diffview")
    then
      return true
    end
  end
  return false
end

local function close_diffview()
  if opened_on_boot() then
    vim.cmd("qa")
    return
  end

  vim.cmd.DiffviewClose()
end

return {
  "sindrets/diffview.nvim",
  keys = {
    { "<leader>gd", "<cmd>DiffviewOpen<cr>", desc = "Diff view" },
    { "<leader>gf", "<cmd>DiffviewFileHistory %<cr>", desc = "File history" },
    { "<leader>gl", "<cmd>DiffviewFileHistory<cr>", desc = "Git log" },
  },
  cmd = { "DiffviewOpen", "DiffviewFileHistory" },
  config = function()
    local actions = require("diffview.actions")
    require("diffview").setup({
      enhanced_diff_hl = true,

      keymaps = {
        view = {
          ["q"] = close_diffview,
        },
        file_panel = {
          ["q"] = close_diffview,
          {
            "n",
            "<Right>",
            actions.select_entry,
            { desc = "Open the diff for the selected entry" },
          },
          {
            "n",
            "<cr>",
            actions.focus_entry,
            { desc = "Focus the diff entry" },
          },
        },
        file_history_panel = {
          ["q"] = close_diffview,

          {
            "n",
            "<Left>",
            actions.select_entry,
            { desc = "Open the diff for the selected entry" },
          },
          {
            "n",
            "<Right>",
            actions.select_entry,
            { desc = "Open the diff for the selected entry" },
          },
          {
            "n",
            "<cr>",
            actions.focus_entry,
            { desc = "Focus the diff entry" },
          },
        },
      },

      hooks = {
        diff_buf_win_enter = function()
          -- vim.opt_local.foldenable = false
        end,
      },
    })

    local diffview_group =
      vim.api.nvim_create_augroup("DiffViewCustom", { clear = true })
    vim.api.nvim_create_autocmd({ "CursorMoved", "CursorMovedI" }, {
      desc = "",
      group = diffview_group,
      pattern = {
        "*DiffviewFilePanel",
        "*DiffviewFileHistoryPanel",
      },
      callback = function(_)
        local lib = require("diffview.lib")
        local view = lib.get_current_view()
        local cur_file = view:infer_cur_file()

        if cur_file then
          actions.select_entry(cur_file)
        end
      end,
    })
  end,
}
