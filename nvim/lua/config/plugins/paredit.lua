local function lsp_wrapped_command(lsp_cmd, fallback_fn)
  local cmd = lsp_cmd

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

local function zpr(input)
  local result = vim.fn.system(
    "echo '" .. input .. "' | zpr '{:style [:indent-only :respect-nl]}'"
  )
  if result then
    return result:gsub("\r?\n$", "")
  end
  return input
end

local function zprint_indent(event, _opts)
  local api = vim.api
  local range = { event.parent:parent():range() }
  local lines = api.nvim_buf_get_text(0, range[1], 0, range[3], range[4], {})
  local text = table.concat(lines, "\n")
  local result = zpr(text)
  if result then
    local base_indent = string.rep(" ", range[2])
    local formatted_lines = {}
    for line in result:gmatch("[^\r\n]+") do
      table.insert(formatted_lines, base_indent .. line)
    end
    api.nvim_buf_set_text(0, range[1], 0, range[3], range[4], formatted_lines)
  end
end

local function load_paredit()
  local paredit = require("nvim-paredit")

  local lsp_drag_form_forwards =
    lsp_wrapped_command("drag-forward", paredit.api.drag_form_forwards)
  local lsp_drag_form_backwards =
    lsp_wrapped_command("drag-backward", paredit.api.drag_form_backwards)
  -- local lsp_slurp_forwards =
  --   lsp_wrapped_command("forward-slurp", paredit.api.slurp_forwards)
  -- local lsp_slurp_backwards =
  --   lsp_wrapped_command("backward-slurp", paredit.api.slurp_backwards)
  -- local lsp_barf_forwards =
  --   lsp_wrapped_command("forward-barf", paredit.api.barf_forwards)
  -- local lsp_barf_backwards =
  --   lsp_wrapped_command("backward-barf", paredit.api.barf_backwards)

  paredit.setup({
    filetypes = { "clojure" },
    cursor_behaviour = "auto",
    use_default_keys = false,
    indent = {
      enabled = true,
      indentor = require("nvim-paredit.indentation.native").indentor,
    },
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
        paredit.api.move_to_next_element_tail,
        "Jump to next element tail",
        repeatable = false,
        mode = { "n", "x", "o", "v" },
      },
      ["W"] = {
        paredit.api.move_to_next_element_head,
        "Jump to next element head",
        repeatable = false,
        mode = { "n", "x", "o", "v" },
      },

      ["B"] = {
        paredit.api.move_to_prev_element_head,
        "Jump to previous element head",
        repeatable = false,
        mode = { "n", "x", "o", "v" },
      },
      ["gE"] = {
        paredit.api.move_to_prev_element_tail,
        "Jump to previous element tail",
        repeatable = false,
        mode = { "n", "x", "o", "v" },
      },
      ["("] = {
        paredit.api.move_to_parent_form_start,
        "Jump to parent form's head",
        repeatable = false,
        mode = { "n", "x", "v" },
      },
      [")"] = {
        paredit.api.move_to_parent_form_end,
        "Jump to parent form's tail",
        repeatable = false,
        mode = { "n", "x", "v" },
      },
      -- These are text object selection keybindings which can used with standard `d, y, c`, `v`
      ["af"] = {
        paredit.api.select_around_form,
        "Around form",
        repeatable = false,
        mode = { "o", "v" },
      },
      ["if"] = {
        paredit.api.select_in_form,
        "In form",
        repeatable = false,
        mode = { "o", "v" },
      },
      ["aF"] = {
        paredit.api.select_around_top_level_form,
        "Around top level form",
        repeatable = false,
        mode = { "o", "v" },
      },
      ["iF"] = {
        paredit.api.select_in_top_level_form,
        "In top level form",
        repeatable = false,
        mode = { "o", "v" },
      },
      ["ae"] = {
        paredit.api.select_element,
        "Around element",
        repeatable = false,
        mode = { "o", "v" },
      },
      ["ie"] = {
        paredit.api.select_element,
        "Element",
        repeatable = false,
        mode = { "o", "v" },
      },
      ["<localleader>w"] = {
        function()
          local range = paredit.wrap.wrap_element_under_cursor("( ", ")")
          paredit.cursor.place_cursor(
            range,
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

      ["<localleader>wc"] = {
        function()
          paredit.wrap.wrap_enclosing_form_under_cursor("(sc.api/spy ", ")")
        end,
        "Wrap with scope capture spy",
      },

      ["<localleader>wt"] = {
        function()
          paredit.wrap.wrap_enclosing_form_under_cursor("(doto ", " tap>)")
        end,
        "Wrap with doto tap>",
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

return {
  "julienvincent/nvim-paredit",
  -- branch = "auto-indentation",
  -- dir = "/Users/armed/Developer/oss/nvim-paredit",
  ft = { "clojure" },
  enabled = true,
  config = load_paredit,
}
