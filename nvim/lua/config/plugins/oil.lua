local M = {
  'stevearc/oil.nvim',
  cmd = 'Oil',
}

function M.config()
  local oil = require('oil')

  oil.setup({
    use_default_keymaps = false,
    keymaps = {
      ["g?"] = "actions.show_help",
      ["<CR>"] = "actions.select",
      ["<C-v>"] = "actions.select_vsplit",
      ["<C-s>"] = "actions.select_split",
      ["<Tab>"] = "actions.preview",
      ["<C-c>"] = "actions.close",
      ["<C-o>"] = "actions.refresh",
      ["-"] = "actions.parent",
      ["_"] = "actions.open_cwd",
      ["`"] = "actions.cd",
      ["~"] = "actions.tcd",
      ["g."] = "actions.toggle_hidden",
    },
  })
end

return M
