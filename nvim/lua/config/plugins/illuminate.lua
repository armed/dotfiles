return {
  'RRethy/vim-illuminate',
  event = 'BufReadPost',

  config = function()
    require('illuminate').configure {
      delay = 100,
      providers = { 'lsp' }
    }
  end,
  init = function()
    vim.cmd('hi link IlluminatedWordRead LspReferenceRead')
    vim.cmd('hi link IlluminatedWordWrite LspReferenceWrite')
    vim.cmd('hi link IlluminatedWordText LspReferenceRead')
    vim.keymap.set('n', ']]', function()
      require('illuminate').goto_next_reference(true)
    end, { desc = 'Next Reference' })
    vim.keymap.set('n', '[[', function()
      require('illuminate').goto_prev_reference(true)
    end, { desc = 'Prev Reference' })
  end,
}

