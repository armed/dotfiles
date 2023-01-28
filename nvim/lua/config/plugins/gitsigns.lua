return {
  'lewis6991/gitsigns.nvim',
  event = 'BufReadPost',
  opts = {
    current_line_blame_opts = {
      delay = 300,
    },
    signs = {
      add = { text = '+' },
      change = { text = '~' },
      delete = { text = '_' },
      topdelete = { text = '‾' },
      changedelete = { text = '~' },
    },
  }
}

