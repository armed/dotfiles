local M = {}

function M.init()
  if vim.g.neovide then
    vim.g.neovide_input_macos_alt_is_meta = true
    vim.o.guifont = "JetBrainsMono Nerd Font Mono:h14"

    vim.keymap.set("n", "<d-s>", ":w<cr>") -- save
    vim.keymap.set("v", "<d-c>", '"+y') -- copy
    vim.keymap.set({ "n", "x", "s", "i", "c", "t" }, "<D-v>", function()
      vim.api.nvim_paste(vim.fn.getreg("+"), true, -1)
    end, { silent = true, desc = "Paste clipboard" })

    local change_scale_factor = function(delta)
      vim.g.neovide_scale_factor = (vim.g.neovide_scale_factor or 1) * delta
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
