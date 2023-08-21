local function vim_sexp_mappings()
  local function map(mode, rhs, lhs, opts)
    opts.buffer = 0
    vim.keymap.set(mode, rhs, lhs, opts)
  end

  local function xmap(rhs, lhs, opts)
    map("x", rhs, lhs, opts)
  end

  local function nmap(rhs, lhs, opts)
    map("n", rhs, lhs, opts)
  end

  local function omap(rhs, lhs, opts)
    map("o", rhs, lhs, opts)
  end

  local function imap(rhs, lhs, opts)
    map("i", rhs, lhs, opts)
  end

  xmap("af", "<Plug>(sexp_outer_list)", { desc = "Sexp outer list" })
  omap("af", "<Plug>(sexp_outer_list)", { desc = "Sexp outer list" })
  xmap("if", "<Plug>(sexp_inner_list)", { desc = "Sexp inner list" })
  omap("if", "<Plug>(sexp_inner_list)", { desc = "Sexp inner list" })
  xmap("aF", "<Plug>(sexp_outer_top_list)", { desc = "Sexp outer top list" })
  omap("aF", "<Plug>(sexp_outer_top_list)", { desc = "Sexp outer top list" })
  xmap("iF", "<Plug>(sexp_inner_top_list)", { desc = "Sexp inner top list" })
  omap("iF", "<Plug>(sexp_inner_top_list)", { desc = "Sexp inner top list" })
  xmap("as", "<Plug>(sexp_outer_string)", { desc = "Sexp outer string" })
  omap("as", "<Plug>(sexp_outer_string)", { desc = "Sexp outer string" })
  xmap("is", "<Plug>(sexp_inner_string)", { desc = "Sexp inner string" })
  omap("is", "<Plug>(sexp_inner_string)", { desc = "Sexp inner string" })
  xmap("ae", "<Plug>(sexp_outer_element)", { desc = "Sexp outer element" })
  omap("ae", "<Plug>(sexp_outer_element)", { desc = "Sexp outer element" })
  xmap("ie", "<Plug>(sexp_inner_element)", { desc = "Sexp inner element" })
  omap("ie", "<Plug>(sexp_inner_element)", { desc = "Sexp inner element" })
  nmap(
    "(",
    "<Plug>(sexp_move_to_prev_bracket)",
    { desc = "Sexp move to prev bracket" }
  )
  nmap(
    ")",
    "<Plug>(sexp_move_to_next_bracket)",
    { desc = "Sexp move to next bracket" }
  )
  nmap(
    "<M-w>",
    "<Plug>(sexp_move_to_next_element_head)",
    { desc = "Sexp move to next element head" }
  )
  xmap(
    "<M-w>",
    "<Plug>(sexp_move_to_next_element_head)",
    { desc = "Sexp move to next element head" }
  )
  omap(
    "<M-w>",
    "<Plug>(sexp_move_to_next_element_head)",
    { desc = "Sexp move to next element head" }
  )
  nmap(
    "g<M-e>",
    "<Plug>(sexp_move_to_prev_element_tail)",
    { desc = "Sexp move to prev element tail" }
  )
  xmap(
    "g<M-e>",
    "<Plug>(sexp_move_to_prev_element_tail)",
    { desc = "Sexp move to prev element tail" }
  )
  omap(
    "g<M-e>",
    "<Plug>(sexp_move_to_prev_element_tail)",
    { desc = "Sexp move to prev element tail" }
  )
  nmap(
    "[e",
    "<Plug>(sexp_select_prev_element)",
    { desc = "Sexp select prev element" }
  )
  xmap(
    "[e",
    "<Plug>(sexp_select_prev_element)",
    { desc = "Sexp select prev element" }
  )
  omap(
    "[e",
    "<Plug>(sexp_select_prev_element)",
    { desc = "Sexp select prev element" }
  )
  nmap(
    "]e",
    "<Plug>(sexp_select_next_element)",
    { desc = "Sexp select next element" }
  )
  xmap(
    "]e",
    "<Plug>(sexp_select_next_element)",
    { desc = "Sexp select next element" }
  )
  omap(
    "]e",
    "<Plug>(sexp_select_next_element)",
    { desc = "Sexp select next element" }
  )
  nmap("==", "<Plug>(sexp_indent)", { desc = "Sexp indent" })
  nmap("=-", "<Plug>(sexp_indent_top)", { desc = "Sexp indent top" })
  nmap(
    "<LocalLeader>[",
    "<Plug>(sexp_square_head_wrap_list)",
    { desc = "Sexp square head wrap list" }
  )
  xmap(
    "<LocalLeader>[",
    "<Plug>(sexp_square_head_wrap_list)",
    { desc = "Sexp square head wrap list" }
  )
  nmap(
    "<LocalLeader>]",
    "<Plug>(sexp_square_tail_wrap_list)",
    { desc = "Sexp square tail wrap list" }
  )
  xmap(
    "<LocalLeader>]",
    "<Plug>(sexp_square_tail_wrap_list)",
    { desc = "Sexp square tail wrap list" }
  )
  nmap(
    "<LocalLeader>{",
    "<Plug>(sexp_curly_head_wrap_list)",
    { desc = "Sexp curly head wrap list" }
  )
  xmap(
    "<LocalLeader>{",
    "<Plug>(sexp_curly_head_wrap_list)",
    { desc = "Sexp curly head wrap list" }
  )
  nmap(
    "<LocalLeader>}",
    "<Plug>(sexp_curly_tail_wrap_list)",
    { desc = "Sexp curly tail wrap list" }
  )
  xmap(
    "<LocalLeader>}",
    "<Plug>(sexp_curly_tail_wrap_list)",
    { desc = "Sexp curly tail wrap list" }
  )
  nmap(
    "<LocalLeader>e[",
    "<Plug>(sexp_square_head_wrap_element)",
    { desc = "Sexp square head wrap element" }
  )
  xmap(
    "<LocalLeader>e[",
    "<Plug>(sexp_square_head_wrap_element)",
    { desc = "Sexp square head wrap element" }
  )
  nmap(
    "<LocalLeader>e]",
    "<Plug>(sexp_square_tail_wrap_element)",
    { desc = "Sexp square tail wrap element" }
  )
  xmap(
    "<LocalLeader>e]",
    "<Plug>(sexp_square_tail_wrap_element)",
    { desc = "Sexp square tail wrap element" }
  )
  nmap(
    "<LocalLeader>e{",
    "<Plug>(sexp_curly_head_wrap_element)",
    { desc = "Sexp curly head wrap element" }
  )
  xmap(
    "<LocalLeader>e{",
    "<Plug>(sexp_curly_head_wrap_element)",
    { desc = "Sexp curly head wrap element" }
  )
  nmap(
    "<LocalLeader>e}",
    "<Plug>(sexp_curly_tail_wrap_element)",
    { desc = "Sexp curly tail wrap element" }
  )
  xmap(
    "<LocalLeader>e}",
    "<Plug>(sexp_curly_tail_wrap_element)",
    { desc = "Sexp curly tail wrap element" }
  )
  nmap(
    "<LocalLeader>h",
    "<Plug>(sexp_insert_at_list_head)",
    { desc = "Sexp insert at list head" }
  )
  nmap(
    "<LocalLeader>l",
    "<Plug>(sexp_insert_at_list_tail)",
    { desc = "Sexp insert at list tail" }
  )
  nmap(
    "<LocalLeader>@",
    "<Plug>(sexp_splice_list)",
    { desc = "Sexp splice list" }
  )
  imap(
    "<BS>",
    "<Plug>(sexp_insert_backspace)",
    { desc = "Sexp insert backspace" }
  )
  -- imap(
  --   '"',
  --   "<Plug>(sexp_insert_double_quote)",
  --   { desc = "Sexp insert double quote" }
  -- )
  -- imap(
  --   "(",
  --   "<Plug>(sexp_insert_opening_round)",
  --   { desc = "Sexp insert opening round" }
  -- )
  -- imap(
  --   ")",
  --   "<Plug>(sexp_insert_closing_round)",
  --   { desc = "Sexp insert closing round" }
  -- )
  -- imap(
  --   "[",
  --   "<Plug>(sexp_insert_opening_square)",
  --   { desc = "Sexp insert opening square" }
  -- )
  -- imap(
  --   "]",
  --   "<Plug>(sexp_insert_closing_square)",
  --   { desc = "Sexp insert closing square" }
  -- )
  -- imap(
  --   "{",
  --   "<Plug>(sexp_insert_opening_curly)",
  --   { desc = "Sexp insert opening curly" }
  -- )
  -- imap(
  --   "}",
  --   "<Plug>(sexp_insert_closing_curly)",
  --   { desc = "Sexp insert closing curly" }
  -- )

  -- nmap(
  --   "<LocalLeader>w",
  --   "<Plug>(sexp_round_head_wrap_element)",
  --   { desc = "Sexp round head wrap element" }
  -- )
  -- xmap(
  --   "<LocalLeader>w",
  --   "<Plug>(sexp_round_head_wrap_element)",
  --   { desc = "Sexp round head wrap element" }
  -- )
  -- nmap(
  --   "<LocalLeader>W",
  --   "<Plug>(sexp_round_tail_wrap_element)",
  --   { desc = "Sexp round tail wrap element" }
  -- )
  -- xmap(
  --   "<LocalLeader>W",
  --   "<Plug>(sexp_round_tail_wrap_element)",
  --   { desc = "Sexp round tail wrap element" }
  -- )
  --   nmap(
  --   "<LocalLeader>i",
  --   "<Plug>(sexp_round_head_wrap_list)",
  --   { desc = "Sexp round head wrap list" }
  -- )
  -- xmap(
  --   "<LocalLeader>i",
  --   "<Plug>(sexp_round_head_wrap_list)",
  --   { desc = "Sexp round head wrap list" }
  -- )
  -- nmap(
  --   "<LocalLeader>I",
  --   "<Plug>(sexp_round_tail_wrap_list)",
  --   { desc = "Sexp round tail wrap list" }
  -- )
  -- xmap(
  --   "<LocalLeader>I",
  --   "<Plug>(sexp_round_tail_wrap_list)",
  --   { desc = "Sexp round tail wrap list" }
  -- )
end

local autocmd = vim.api.nvim_create_autocmd
local augroup = vim.api.nvim_create_augroup

-- General Settings
local sexp = augroup("Vim Sexp", { clear = true })

autocmd("FileType", {
  group = sexp,
  pattern = { "clojure", "fennel" },
  callback = vim_sexp_mappings,
})

return {
  "guns/vim-sexp",

  ft = { "clojure", "lisp", "fennel", "scheme", "janet" },

  init = function()
    -- vim.g.sexp_filetypes = "clojure,scheme,lisp,fennel,janet"
    vim.g.sexp_filetypes = ""
  end,

  dependencies = {
    "radenling/vim-dispatch-neovim",
    "tpope/vim-sexp-mappings-for-regular-people",
    "tpope/vim-repeat",
  },
}
