local function lsp_wrapped_drag(is_forward, fallback_fn)
  local cmd
  if is_forward then
    cmd = "drag-forward"
  else
    cmd = "drag-backward"
  end

  return function()
    local pos = vim.api.nvim_win_get_cursor(0)
    local client = vim.lsp.get_clients({
      name = "clojure_lsp",
    })
    if client ~= nil and next(client) then
      vim.lsp.buf.execute_command({
        command = cmd,
        arguments = {
          vim.uri_from_bufnr(0),
          pos[1] - 1,
          pos[2],
        },
        workDoneToken = "1",
      })
    else
      fallback_fn()
    end
  end
end

return {
  -- "julienvincent/nvim-paredit",
  dir = "~/Developer/neovim/nvim-paredit",
  ft = { "clojure" },
  enabled = true,
  config = function()
    local paredit = require("nvim-paredit")

    local lsp_drag_form_forwards =
      lsp_wrapped_drag(true, paredit.api.drag_form_forwards)
    local lsp_drag_form_backwards =
      lsp_wrapped_drag(false, paredit.api.drag_form_backwards)

    paredit.setup({
      filetypes = { "clojure" },
      cursor_behaviour = "auto",
      use_default_keys = false,
      keys = {
        ["<M-S-l>"] = { paredit.api.slurp_forwards, "Slurp forwards" },
        ["<M-S-h>"] = { paredit.api.slurp_backwards, "Slurp backwards" },

        ["<M-S-k>"] = { paredit.api.barf_forwards, "Barf forwards" },
        ["<M-S-j>"] = { paredit.api.barf_backwards, "Barf backwards" },

        ["<M-l>"] = { lsp_drag_form_forwards, "Drag element fowrad" },
        ["<M-h>"] = { lsp_drag_form_backwards, "Drag element backward" },

        [">f"] = { paredit.api.drag_form_forwards, "Drag form forward" },
        ["<f"] = { paredit.api.drag_form_backwards, "Drag form backward" },

        ["<localleader>o"] = { paredit.api.raise_form, "Raise form" },
        ["<localleader>O"] = { paredit.api.raise_element, "Raise element" },

        ["E"] = {
          paredit.api.move_to_next_element,
          "Jump to next element tail",
          repeatable = false,
          operator = true,
        },
        ["B"] = {
          paredit.api.move_to_prev_element,
          "Jump to previous element head",
          repeatable = false,
          operator = true,
        },
      },
    })
  end,
}
