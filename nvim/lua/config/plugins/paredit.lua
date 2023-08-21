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
      bufnr = 0,
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

-- local function zpr(input)
--   local result = vim.fn.system(
--     "echo '" .. input .. "' | zpr '{:style [:indent-only :respect-nl]}'"
--   )
--   if result then
--     return result:gsub("\r?\n$", "")
--   end
--   return input
-- end
--
-- local function zprint_indent(buf, start, end_)
--   local api = vim.api
--   local lines = api.nvim_buf_get_text(buf, start[1], 0, end_[1], end_[2], {})
--   local text = table.concat(lines, "\n")
--   local result = zpr(text)
--   if result then
--     local base_indent = string.rep(" ", start[2])
--     local formatted_lines = {}
--     for line in result:gmatch("[^\r\n]+") do
--       table.insert(formatted_lines, base_indent .. line)
--     end
--     api.nvim_buf_set_text(buf, start[1], 0, end_[1], end_[2], formatted_lines)
--   end
-- end

local function load_paredit()
  local paredit = require("nvim-paredit")

  local lsp_drag_form_forwards =
    lsp_wrapped_drag(true, paredit.api.drag_form_forwards)
  local lsp_drag_form_backwards =
    lsp_wrapped_drag(false, paredit.api.drag_form_backwards)

  paredit.setup({
    filetypes = { "clojure" },
    cursor_behaviour = "auto",
    use_default_keys = false,
    indent_behaviour = "native",
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
        mode = { "n", "x", "o", "v" },
      },
      ["B"] = {
        paredit.api.move_to_prev_element,
        "Jump to previous element head",
        repeatable = false,
        mode = { "n", "x", "o", "v" },
      },

      ["<localleader>w"] = {
        function()
          paredit.cursor.place_cursor(
            paredit.wrap.wrap_element_under_cursor("( ", ")"),
            { placement = "inner_start", mode = "insert" }
          )
        end,
        "Wrap element insert head",
      },

      ["<localleader>W"] = {
        function()
          paredit.cursor.place_cursor(
            paredit.wrap.wrap_element_under_cursor("(", ")"),
            { placement = "inner_end", mode = "insert" }
          )
        end,
        "Wrap element insert tail",
      },

      ["<localleader>i"] = {
        function()
          paredit.cursor.place_cursor(
            paredit.wrap.wrap_enclosing_form_under_cursor("( ", ")"),
            { placement = "inner_start", mode = "insert" }
          )
        end,
        "Wrap form insert head",
      },

      ["<localleader>I"] = {
        function()
          paredit.cursor.place_cursor(
            paredit.wrap.wrap_enclosing_form_under_cursor("(", ")"),
            { placement = "inner_end", mode = "insert" }
          )
        end,
        "Wrap form insert tail",
      },
    },
  })
end

-- load_paredit()

return {
  "julienvincent/nvim-paredit",
  branch = "auto-indentation",
  -- dir = "/Users/armed/Developer/neovim/nvim-paredit",
  ft = { "clojure" },
  enabled = true,
  config = load_paredit,
}
