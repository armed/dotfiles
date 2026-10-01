local max_filesize = 200 * 1024
local parsers = {
  "bash",
  "clojure",
  "java",
  "javascript",
  "json",
  "just",
  "lua",
  "markdown",
  "markdown_inline",
  "nim",
  "proto",
  "rust",
  "sql",
  "toml",
  "tsx",
  "typescript",
  "xml",
}

local function clear_selection(bufnr)
  for _, mode in ipairs({ "n", "x" }) do
    for _, mapping in ipairs(vim.api.nvim_buf_get_keymap(bufnr, mode)) do
      if
        mapping.desc == "Expand treesitter selection"
        or mapping.desc == "Shrink treesitter selection"
      then
        vim.api.nvim_buf_del_keymap(bufnr, mode, mapping.lhs)
      end
    end
  end
end

local function start(bufnr)
  if not vim.api.nvim_buf_is_loaded(bufnr) or vim.bo[bufnr].buftype ~= "" then
    return
  end
  local lang = vim.treesitter.language.get_lang(vim.bo[bufnr].filetype)
  if not lang or not vim.tbl_contains(parsers, lang) then
    clear_selection(bufnr)
    return
  end
  local size =
    vim.api.nvim_buf_get_offset(bufnr, vim.api.nvim_buf_line_count(bufnr))
  if size > max_filesize then
    -- Built-in ftplugins may have started highlighting before this callback.
    vim.treesitter.stop(bufnr)
    clear_selection(bufnr)
    return
  end
  -- Installation is asynchronous; buffers remain usable until their parser exists.
  if not pcall(vim.treesitter.start, bufnr, lang) then
    return
  end
  local select = require("vim.treesitter._select")
  local opts = { buffer = bufnr, desc = "Expand treesitter selection" }
  vim.keymap.set({ "n", "x" }, "<CR>", function()
    select.select_parent(vim.v.count1)
  end, opts)
  vim.keymap.set("x", "<BS>", function()
    select.select_child(vim.v.count1)
  end, { buffer = bufnr, desc = "Shrink treesitter selection" })
end

return {
  "nvim-treesitter/nvim-treesitter",
  branch = "main",
  lazy = false,
  dependencies = {
    {
      "nvim-treesitter/nvim-treesitter-context",
      opts = { enable = false, max_lines = 2, separator = "_" },
    },
  },
  build = ":TSUpdate",
  config = function()
    local group =
      vim.api.nvim_create_augroup("TreesitterHighlight", { clear = true })
    vim.api.nvim_create_autocmd("FileType", {
      group = group,
      callback = function(args)
        start(args.buf)
      end,
    })
    require("nvim-treesitter").install(parsers):await(function()
      vim.schedule(function()
        for _, bufnr in ipairs(vim.api.nvim_list_bufs()) do
          start(bufnr)
        end
      end)
    end)
    start(vim.api.nvim_get_current_buf())
  end,
}
