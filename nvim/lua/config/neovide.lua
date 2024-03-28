local M = {}

function M.init()
  if vim.g.neovide then
    vim.g.neovide_input_macos_alt_is_meta = true
    -- Allow clipboard copy paste in neovim
    vim.api.nvim_set_keymap(
      "",
      "<D-v>",
      "+p<CR>",
      { noremap = true, silent = true }
    )
    vim.api.nvim_set_keymap(
      "!",
      "<D-v>",
      "<C-R>+",
      { noremap = true, silent = true }
    )
    vim.api.nvim_set_keymap(
      "t",
      "<D-v>",
      "<C-R>+",
      { noremap = true, silent = true }
    )
    vim.api.nvim_set_keymap(
      "v",
      "<D-v>",
      "<C-R>+",
      { noremap = true, silent = true }
    )
    vim.o.guifont = "JetBrainsMono Nerd Font Mono:h14"

    vim.keymap.set("n", "<d-s>", ":w<cr>") -- save
    vim.keymap.set("v", "<d-c>", '"+y') -- copy
    vim.keymap.set("n", "<d-v>", '"+p') -- paste normal mode
    vim.keymap.set("v", "<d-v>", '"+p') -- paste visual mode
    vim.keymap.set("c", "<d-v>", "<c-r>+") -- paste command mode
    vim.keymap.set("i", "<d-v>", "<esc>pi") -- paste insert mode

    local change_scale_factor = function(delta)
      vim.g.neovide_scale_factor = vim.g.neovide_scale_factor * delta
    end
    vim.keymap.set("n", "<D-=>", function()
      change_scale_factor(1.05)
    end)
    vim.keymap.set("n", "<D-0>", function()
      vim.g.neovide_scale_factor = 1.0
    end)
    vim.keymap.set("n", "<D-->", function()
      change_scale_factor(1 / 1.05)
    end)

    vim.g.neovide_floating_shadow = true
    vim.g.neovide_floating_z_height = 10
    vim.g.neovide_light_angle_degrees = 15
    vim.g.neovide_light_radius = 5

    vim.g.neovide_refresh_rate_idle = 5
  end
end

return M
