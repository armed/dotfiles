local M = {}

vim.o.completeopt = "menuone,noselect"

function M.setup()
  local ok, cmp = pcall(require, "cmp")

  if ok then
    return cmp.setup({
      sources = {
        { name = "conjure" },
        { name = "nvim_lsp" },
        { name = "buffer" },
        { name = "path" },
        { name = "cmdline" }
      },
      mapping = cmp.mapping.preset.insert({
        ["<C-b>"] = cmp.mapping.scroll_docs(-4),
        ["<C-f>"] = cmp.mapping.scroll_docs(4),
        ["<C-Space>"] = cmp.mapping.complete(),
        ["<C-e>"] = cmp.mapping.abort(),
        ["<CR>"] = cmp.mapping.confirm({ select = true })
      })
    })
  end
end

return M
