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
  nmap("(", "<Plug>(sexp_move_to_prev_bracket)", { desc = "Sexp move to prev bracket" })
  -- xmap("(", "<Plug>(sexp_move_to_prev_bracket)", { desc = "Sexp move to prev bracket" })
  -- omap("(", "<Plug>(sexp_move_to_prev_bracket)", { desc = "Sexp move to prev bracket" })
  nmap(")", "<Plug>(sexp_move_to_next_bracket)", { desc = "Sexp move to next bracket" })
  -- xmap(")", "<Plug>(sexp_move_to_next_bracket)", { desc = "Sexp move to next bracket" })
  -- omap(")", "<Plug>(sexp_move_to_next_bracket)", { desc = "Sexp move to next bracket" })
  nmap("B", "<Plug>(sexp_move_to_prev_element_head)", { desc = "Sexp move to prev element head" })
  xmap("B", "<Plug>(sexp_move_to_prev_element_head)", { desc = "Sexp move to prev element head" })
  omap("B", "<Plug>(sexp_move_to_prev_element_head)", { desc = "Sexp move to prev element head" })
  nmap("<M-w>", "<Plug>(sexp_move_to_next_element_head)", { desc = "Sexp move to next element head" })
  xmap("<M-w>", "<Plug>(sexp_move_to_next_element_head)", { desc = "Sexp move to next element head" })
  omap("<M-w>", "<Plug>(sexp_move_to_next_element_head)", { desc = "Sexp move to next element head" })
  nmap("g<M-e>", "<Plug>(sexp_move_to_prev_element_tail)", { desc = "Sexp move to prev element tail" })
  xmap("g<M-e>", "<Plug>(sexp_move_to_prev_element_tail)", { desc = "Sexp move to prev element tail" })
  omap("g<M-e>", "<Plug>(sexp_move_to_prev_element_tail)", { desc = "Sexp move to prev element tail" })
  nmap("E", "<Plug>(sexp_move_to_next_element_tail)", { desc = "Sexp move to next element tail" })
  xmap("E", "<Plug>(sexp_move_to_next_element_tail)", { desc = "Sexp move to next element tail" })
  omap("E", "<Plug>(sexp_move_to_next_element_tail)", { desc = "Sexp move to next element tail" })
  -- nmap("[[", "<Plug>(sexp_move_to_prev_top_element)", { desc = "Sexp move to prev top element"})
  -- xmap("[[", "<Plug>(sexp_move_to_prev_top_element)", { desc = "Sexp move to prev top element"})
  -- omap("[[", "<Plug>(sexp_move_to_prev_top_element)", { desc = "Sexp move to prev top element"})
  -- nmap("]]", "<Plug>(sexp_move_to_next_top_element)", { desc = "Sexp move to next top element"})
  -- xmap("]]", "<Plug>(sexp_move_to_next_top_element)", { desc = "Sexp move to next top element"})
  -- omap("]]", "<Plug>(sexp_move_to_next_top_element)", { desc = "Sexp move to next top element"})
  nmap("[e", "<Plug>(sexp_select_prev_element)", { desc = "Sexp select prev element" })
  xmap("[e", "<Plug>(sexp_select_prev_element)", { desc = "Sexp select prev element" })
  omap("[e", "<Plug>(sexp_select_prev_element)", { desc = "Sexp select prev element" })
  nmap("]e", "<Plug>(sexp_select_next_element)", { desc = "Sexp select next element" })
  xmap("]e", "<Plug>(sexp_select_next_element)", { desc = "Sexp select next element" })
  omap("]e", "<Plug>(sexp_select_next_element)", { desc = "Sexp select next element" })
  nmap("==", "<Plug>(sexp_indent)", { desc = "Sexp indent" })
  nmap("=-", "<Plug>(sexp_indent_top)", { desc = "Sexp indent top" })
  nmap("<LocalLeader>i", "<Plug>(sexp_round_head_wrap_list)", { desc = "Sexp round head wrap list" })
  xmap("<LocalLeader>i", "<Plug>(sexp_round_head_wrap_list)", { desc = "Sexp round head wrap list" })
  nmap("<LocalLeader>I", "<Plug>(sexp_round_tail_wrap_list)", { desc = "Sexp round tail wrap list" })
  xmap("<LocalLeader>I", "<Plug>(sexp_round_tail_wrap_list)", { desc = "Sexp round tail wrap list" })
  nmap("<LocalLeader>[", "<Plug>(sexp_square_head_wrap_list)", { desc = "Sexp square head wrap list" })
  xmap("<LocalLeader>[", "<Plug>(sexp_square_head_wrap_list)", { desc = "Sexp square head wrap list" })
  nmap("<LocalLeader>]", "<Plug>(sexp_square_tail_wrap_list)", { desc = "Sexp square tail wrap list" })
  xmap("<LocalLeader>]", "<Plug>(sexp_square_tail_wrap_list)", { desc = "Sexp square tail wrap list" })
  nmap("<LocalLeader>{", "<Plug>(sexp_curly_head_wrap_list)", { desc = "Sexp curly head wrap list" })
  xmap("<LocalLeader>{", "<Plug>(sexp_curly_head_wrap_list)", { desc = "Sexp curly head wrap list" })
  nmap("<LocalLeader>}", "<Plug>(sexp_curly_tail_wrap_list)", { desc = "Sexp curly tail wrap list" })
  xmap("<LocalLeader>}", "<Plug>(sexp_curly_tail_wrap_list)", { desc = "Sexp curly tail wrap list" })
  nmap("<LocalLeader>w", "<Plug>(sexp_round_head_wrap_element)", { desc = "Sexp round head wrap element" })
  xmap("<LocalLeader>w", "<Plug>(sexp_round_head_wrap_element)", { desc = "Sexp round head wrap element" })
  nmap("<LocalLeader>W", "<Plug>(sexp_round_tail_wrap_element)", { desc = "Sexp round tail wrap element" })
  xmap("<LocalLeader>W", "<Plug>(sexp_round_tail_wrap_element)", { desc = "Sexp round tail wrap element" })
  nmap("<LocalLeader>e[", "<Plug>(sexp_square_head_wrap_element)", { desc = "Sexp square head wrap element" })
  xmap("<LocalLeader>e[", "<Plug>(sexp_square_head_wrap_element)", { desc = "Sexp square head wrap element" })
  nmap("<LocalLeader>e]", "<Plug>(sexp_square_tail_wrap_element)", { desc = "Sexp square tail wrap element" })
  xmap("<LocalLeader>e]", "<Plug>(sexp_square_tail_wrap_element)", { desc = "Sexp square tail wrap element" })
  nmap("<LocalLeader>e{", "<Plug>(sexp_curly_head_wrap_element)", { desc = "Sexp curly head wrap element" })
  xmap("<LocalLeader>e{", "<Plug>(sexp_curly_head_wrap_element)", { desc = "Sexp curly head wrap element" })
  nmap("<LocalLeader>e}", "<Plug>(sexp_curly_tail_wrap_element)", { desc = "Sexp curly tail wrap element" })
  xmap("<LocalLeader>e}", "<Plug>(sexp_curly_tail_wrap_element)", { desc = "Sexp curly tail wrap element" })
  nmap("<LocalLeader>h", "<Plug>(sexp_insert_at_list_head)", { desc = "Sexp insert at list head" })
  nmap("<LocalLeader>l", "<Plug>(sexp_insert_at_list_tail)", { desc = "Sexp insert at list tail" })
  nmap("<LocalLeader>@", "<Plug>(sexp_splice_list)", { desc = "Sexp splice list" })
  nmap("<LocalLeader>o", "<Plug>(sexp_raise_list)", { desc = "Sexp raise list" })
  xmap("<LocalLeader>o", "<Plug>(sexp_raise_list)", { desc = "Sexp raise list" })
  nmap("<LocalLeader>O", "<Plug>(sexp_raise_element)", { desc = "Sexp raise element" })
  xmap("<LocalLeader>O", "<Plug>(sexp_raise_element)", { desc = "Sexp raise element" })
  nmap("<M-k>", "<Plug>(sexp_swap_list_backward)", { desc = "Sexp swap list backward" })
  xmap("<M-k>", "<Plug>(sexp_swap_list_backward)", { desc = "Sexp swap list backward" })
  nmap("<M-j>", "<Plug>(sexp_swap_list_forward)", { desc = "Sexp swap list forward" })
  xmap("<M-j>", "<Plug>(sexp_swap_list_forward)", { desc = "Sexp swap list forward" })
  nmap("<M-h>", "<Plug>(sexp_swap_element_backward)", { desc = "Sexp swap element backward" })
  xmap("<M-h>", "<Plug>(sexp_swap_element_backward)", { desc = "Sexp swap element backward" })
  nmap("<M-l>", "<Plug>(sexp_swap_element_forward)", { desc = "Sexp swap element forward" })
  xmap("<M-l>", "<Plug>(sexp_swap_element_forward)", { desc = "Sexp swap element forward" })
  nmap("<M-S-j>", "<Plug>(sexp_emit_head_element)", { desc = "Sexp emit head element" })
  xmap("<M-S-j>", "<Plug>(sexp_emit_head_element)", { desc = "Sexp emit head element" })
  nmap("<M-S-k>", "<Plug>(sexp_emit_tail_element)", { desc = "Sexp emit tail element" })
  xmap("<M-S-k>", "<Plug>(sexp_emit_tail_element)", { desc = "Sexp emit tail element" })
  nmap("<M-S-h>", "<Plug>(sexp_capture_prev_element)", { desc = "Sexp capture prev element" })
  xmap("<M-S-h>", "<Plug>(sexp_capture_prev_element)", { desc = "Sexp capture prev element" })
  nmap("<M-S-l>", "<Plug>(sexp_capture_next_element)", { desc = "Sexp capture next element" })
  xmap("<M-S-l>", "<Plug>(sexp_capture_next_element)", { desc = "Sexp capture next element" })
  imap("<BS>", "<Plug>(sexp_insert_backspace)", { desc = "Sexp insert backspace" })
  imap('"', "<Plug>(sexp_insert_double_quote)", { desc = "Sexp insert double quote" })
  imap("(", "<Plug>(sexp_insert_opening_round)", { desc = "Sexp insert opening round" })
  imap(")", "<Plug>(sexp_insert_closing_round)", { desc = "Sexp insert closing round" })
  imap("[", "<Plug>(sexp_insert_opening_square)", { desc = "Sexp insert opening square" })
  imap("]", "<Plug>(sexp_insert_closing_square)", { desc = "Sexp insert closing square" })
  imap("{", "<Plug>(sexp_insert_opening_curly)", { desc = "Sexp insert opening curly" })
  imap("}", "<Plug>(sexp_insert_closing_curly)", { desc = "Sexp insert closing curly" })
end

local autocmd = vim.api.nvim_create_autocmd
local augroup = vim.api.nvim_create_augroup

-- General Settings
local sexp = augroup("Vim Sexp", { clear = true })

autocmd("FileType", {
  group = sexp,
  pattern = { "clojure" },
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
