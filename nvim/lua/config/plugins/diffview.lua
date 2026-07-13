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

local jd = { info = "", win = nil, buf = nil }
local JD_COLLAPSED = 1

local function jd_lines()
  local lines = vim.split(jd.info, "\n", { plain = true })
  while #lines > 1 and lines[#lines] == "" do
    table.remove(lines)
  end
  return lines
end

local function jd_valid()
  return jd.win ~= nil and vim.api.nvim_win_is_valid(jd.win)
end

local function jd_close()
  if jd_valid() then
    vim.api.nvim_win_close(jd.win, true)
  end
  jd.win = nil
  jd.buf = nil
end

local function jd_open()
  jd.info = vim.env.JD_INFO or ""
  if jd.info == "" or jd_valid() then
    return
  end

  local buf = vim.api.nvim_create_buf(false, true)
  vim.bo[buf].buftype = "nofile"
  vim.bo[buf].bufhidden = "wipe"
  vim.api.nvim_buf_set_lines(buf, 0, -1, false, jd_lines())
  vim.bo[buf].modifiable = false

  -- `q` from the message pane closes the whole diff, same as the diff windows.
  vim.keymap.set("n", "q", close_diffview, { buffer = buf, nowait = true })

  local cur = vim.api.nvim_get_current_win()
  vim.cmd("botright split")
  local win = vim.api.nvim_get_current_win()
  vim.api.nvim_win_set_buf(win, buf)
  vim.wo[win].number = false
  vim.wo[win].relativenumber = false
  vim.wo[win].signcolumn = "no"
  vim.wo[win].cursorline = false
  vim.wo[win].winfixheight = true
  vim.wo[win].wrap = false
  vim.api.nvim_win_set_height(win, JD_COLLAPSED)

  jd.win = win
  jd.buf = buf
  vim.api.nvim_set_current_win(cur)
end

-- Expand to fit the whole message while focused; collapse back to one line.
local jd_group = vim.api.nvim_create_augroup("JdCommitPane", { clear = true })
vim.api.nvim_create_autocmd("WinEnter", {
  group = jd_group,
  callback = function()
    if jd_valid() and vim.api.nvim_get_current_win() == jd.win then
      vim.api.nvim_win_set_height(jd.win, math.max(JD_COLLAPSED, #jd_lines()))
    end
  end,
})
vim.api.nvim_create_autocmd("WinLeave", {
  group = jd_group,
  callback = function()
    if jd_valid() and vim.api.nvim_get_current_win() == jd.win then
      -- Reset to the first line so the collapsed view shows the subject.
      vim.api.nvim_win_set_cursor(jd.win, { 1, 0 })
      vim.api.nvim_win_set_height(jd.win, JD_COLLAPSED)
    end
  end,
})

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
        -- Schedule so the pane is created after Diffview finishes its layout.
        view_opened = function()
          vim.schedule(jd_open)
        end,
        view_closed = function()
          jd_close()
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
