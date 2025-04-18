local autocmd = vim.api.nvim_create_autocmd
local augroup = vim.api.nvim_create_augroup

-- General Settings
local general = augroup("General Settings", { clear = true })

autocmd({ "VimEnter", "DirChanged" }, {
  callback = function(data)
    -- buffer is a directory
    local directory = vim.fn.isdirectory(data.file) == 1

    -- change to the directory
    if directory then
      vim.cmd.cd(data.file)
      -- open the tree
      vim.cmd("Neotree")
    end
    local current_dir = vim.fn.getcwd()
    if current_dir and current_dir ~= "/" then
      local current_dir_name = current_dir:match("([^/]+)$")
      vim.schedule(function()
        vim.o.titlestring = "[nv]" .. current_dir_name
      end)
    end
  end,
  group = general,
  desc = "Open NvimTree when it's a Directory",
})

autocmd("TermOpen", {
  callback = function(evt)
    vim.opt_local.relativenumber = false
    vim.opt_local.number = false
    local opts = { buffer = 0 }
    local map = vim.keymap.set
    -- map("t", "<esc><esc>", "<C-\\><C-n>", opts)
    map("t", "jj", "<C-\\><C-n>", opts)
    map("t", "qq", "<C-\\><C-n>:close<CR>", opts)
    map("n", "q", ":close<CR>", opts)
    vim.cmd("startinsert!")
  end,
  pattern = "term://*",
  group = general,
  desc = "Terminal Options",
})

-- Check if we need to reload the file when it changed
autocmd({ "FocusGained", "TermClose", "TermLeave" }, { command = "checktime" })

-- Highlight on yank
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
    vim.cmd("tabdo wincmd =")
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
    -- some themes cleans hl groups, we are overriding them here
    require("config.hl-groups").init()
  end,
})

-- Automatically close buffer if the underlying file is deleted
local function check_and_delete_buffer()
  local buf = vim.api.nvim_get_current_buf()
  local bufname = vim.api.nvim_buf_get_name(buf)

  -- Use vim.bo[bufnr].optionname to get buffer-local options
  local modified = vim.bo[buf].modified
  local buftype = vim.bo[buf].buftype

  -- Proceed only if the buffer has a name, is not modified, and is a normal buffer
  -- (buftype is empty string for normal buffers)
  if bufname ~= "" and not modified and buftype == "" then
    -- vim.fn.filereadable returns 0 if not readable/exists, 1 if it does
    if vim.fn.filereadable(bufname) == 0 then
      -- File deleted/missing, close the buffer
      vim.notify(
        "File deleted, closing buffer: " .. vim.fn.fnamemodify(bufname, ":t"),
        vim.log.levels.INFO
      )
      -- Use vim.schedule to ensure command runs safely in the main loop
      vim.schedule(function()
        -- Use silent=true to avoid errors, bang=true to force wipeout
        -- unload=false corresponds to bwipeout
        vim.api.nvim_buf_delete(buf, { force = true, unload = false })
      end)
    end
  end
end

local fs_group = augroup("CloseDeletedBuffer", { clear = true })

-- autocmd({ "FocusGained", "CursorHold" }, {
--   group = fs_group,
--   pattern = "*",
--   callback = check_and_delete_buffer,
--   desc = "Close buffer if underlying file is deleted",
-- })
