local M = {}

function M.setup()
  for name, target in pairs({
    IlluminatedWordRead = "LspReferenceRead",
    IlluminatedWordWrite = "LspReferenceWrite",
    IlluminatedWordText = "LspReferenceRead",
  }) do
    vim.api.nvim_set_hl(0, name, { link = target })
  end
  vim.api.nvim_set_hl(
    0,
    "user.repl.winbar",
    { bg = "#ffaa88", fg = "black", bold = true }
  )
  vim.api.nvim_set_hl(
    0,
    "user.repl.statusline",
    { fg = "#ffaa88", bold = true }
  )
  vim.api.nvim_set_hl(
    0,
    "user.win.title",
    { fg = "black", bg = "grey", default = true }
  )
  vim.api.nvim_set_hl(0, "Green", { fg = "#98bb6c", bold = true })
  vim.api.nvim_set_hl(
    0,
    "ClojureSystemRestart",
    { fg = "#27F53C", bold = true }
  )
  vim.api.nvim_set_hl(0, "ClojureSystemStop", { fg = "#F54927", bold = true })
end

return M
