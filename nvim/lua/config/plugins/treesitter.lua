local max_filesize = 200 * 1024 -- 200 KB

local M = {
  "nvim-treesitter/nvim-treesitter",
  branch = "main",
  lazy = false,
  dependencies = {
    {
      "nvim-treesitter/nvim-treesitter-context",
      opts = {
        enable = false,
        patterns = {
          clojure = {
            "list_lit",
            "vec_lit",
            "map_lit",
            "set_lit",
          },
        },
        max_lines = 2,
        separator = "_",
      },
    },
  },
  event = "BufReadPost",
  build = ":TSUpdate",
}

function M.config()
  require("nvim-treesitter").install({ "lua", "clojure" })

  vim.api.nvim_create_autocmd("FileType", {
    pattern = { "clojure" },
    callback = function(ev)
      local ok, stats = pcall(vim.uv.fs_stat, vim.api.nvim_buf_get_name(ev.buf))
      if ok and stats and stats.size > max_filesize then
        return
      end
      vim.treesitter.start(ev.buf)
    end,
  })

  local select = require("vim.treesitter._select")
  vim.keymap.set("n", "<CR>", function()
    select.select_parent(vim.v.count1)
  end, { desc = "Init treesitter selection" })
  vim.keymap.set("x", "<CR>", function()
    select.select_parent(vim.v.count1)
  end, { desc = "Expand treesitter selection" })
  vim.keymap.set("x", "<BS>", function()
    select.select_child(vim.v.count1)
  end, { desc = "Shrink treesitter selection" })
end

return M
