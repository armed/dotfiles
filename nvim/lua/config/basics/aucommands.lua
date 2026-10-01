local autocmd = vim.api.nvim_create_autocmd
local augroup = vim.api.nvim_create_augroup

-- General Settings
local general = augroup("General Settings", { clear = true })

autocmd(
  { "FocusGained", "TermClose", "TermLeave" },
  { group = general, command = "checktime" }
)

autocmd("TextYankPost", {
  group = general,
  callback = function()
    vim.highlight.on_yank()
  end,
  desc = "Highlight on Yank",
})

-- resize splits if window got resized
autocmd({ "VimResized" }, {
  group = general,
  callback = function()
    local tab = vim.api.nvim_get_current_tabpage()
    vim.cmd("tabdo wincmd =")
    if vim.api.nvim_tabpage_is_valid(tab) then
      vim.api.nvim_set_current_tabpage(tab)
    end
  end,
  desc = "Equalize windows on resize",
})

-- go to last loc when opening a buffer
autocmd("BufReadPost", {
  group = general,
  callback = function()
    local mark = vim.api.nvim_buf_get_mark(0, '"')
    local lcount = vim.api.nvim_buf_line_count(0)
    if mark[1] > 0 and mark[1] <= lcount then
      pcall(vim.api.nvim_win_set_cursor, 0, mark)
    end
  end,
})

-- close some filetypes with <q>
autocmd("FileType", {
  group = general,
  pattern = {
    "qf",
    "help",
    "man",
    "notify",
    "lspinfo",
    "spectre_panel",
    "startuptime",
    "tsplayground",
    "nvim-docs-view",
    "PlenaryTestPopup",
  },
  callback = function(event)
    vim.bo[event.buf].buflisted = false
    vim.keymap.set(
      "n",
      "q",
      "<cmd>close<cr>",
      { buffer = event.buf, silent = true }
    )
  end,
  desc = "Close by q",
})

autocmd("FileType", {
  group = general,
  pattern = { "gitcommit", "markdown" },
  callback = function()
    vim.opt_local.wrap = true
    vim.opt_local.spell = true
  end,
})

autocmd("FileType", {
  group = general,
  pattern = { "nvim-docs-view" },
  callback = function()
    vim.opt_local.conceallevel = 3
  end,
})

autocmd("FileType", {
  group = general,
  pattern = { "nim" },
  callback = function()
    vim.opt_local.commentstring = "# %s"
  end,
})

autocmd("ColorScheme", {
  group = general,
  pattern = "*",
  callback = function()
    require("config.basics.hl-groups").setup()
  end,
})

autocmd("BufWritePre", {
  group = general,
  pattern = "*",
  callback = function(args)
    local buf = args.buf
    local bo = vim.bo[buf]
    if bo.buftype ~= "" or bo.binary or not bo.modifiable or bo.readonly then
      return
    end
    local last = vim.api.nvim_buf_line_count(buf)
    local keep = last
    while
      keep > 1
      and vim.api.nvim_buf_get_lines(buf, keep - 1, keep, false)[1] == ""
    do
      keep = keep - 1
    end
    if keep == last then
      return
    end
    local views = {}
    for _, win in ipairs(vim.fn.win_findbuf(buf)) do
      views[win] = vim.api.nvim_win_call(win, vim.fn.winsaveview)
    end
    vim.api.nvim_buf_set_lines(buf, keep, last, false, {})
    for win, view in pairs(views) do
      if vim.api.nvim_win_is_valid(win) then
        view.lnum = math.min(view.lnum, keep)
        vim.api.nvim_win_call(win, function()
          vim.fn.winrestview(view)
        end)
      end
    end
  end,
})
