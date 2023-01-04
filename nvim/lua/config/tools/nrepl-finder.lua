local actions = require "telescope.actions"
local action_state = require "telescope.actions.state"

local function run_selection(prompt_bufnr)
  actions.select_default:replace(function()
    actions.close(prompt_bufnr)
    local selection = action_state.get_selected_entry()
    local port = io.lines(selection.path)()
    vim.cmd('ConjureConnect localhost:' .. port)
  end)
  return true
end

local find_opts = require('telescope.themes').get_dropdown({
  borderchars = {
    { '─', '│', '─', '│', '┌', '┐', '┘', '└' },
    prompt = { "─", "│", " ", "│", '┌', '┐', "│", "│" },
    results = { "─", "│", "─", "│", "├", "┤", "┘", "└" },
    preview = { '─', '│', '─', '│', '┌', '┐', '┘', '└' },
  },
  width = 0.8,
  previewer = false,
  prompt_title = false,
  cwd = "~/Developer/transit",
  find_command = {
    'rg',
    '--files',
    '--with-filename',
    '--hidden',
    '-g',
    '!.joyride',
    '-g',
    '.nrepl-port'
  },
  attach_mappings = run_selection
})

local M = {}

function M.find_repls()
  require('telescope.builtin').find_files(find_opts)
end

return M
