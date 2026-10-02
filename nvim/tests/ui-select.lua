dofile("tests/bootstrap.lua")
for _, plugin in ipairs({
  "telescope.nvim",
  "telescope-ui-select.nvim",
  "plenary.nvim",
}) do
  vim.opt.rtp:prepend(vim.fn.stdpath("data") .. "/lazy/" .. plugin)
end
require("config.plugins.telescope").init()
assert(not package.loaded.telescope, "UI setup must leave Telescope lazy")
local selector = vim.ui.select
local choices = {
  { ctx = { client_id = 100 }, action = { title = "First code action" } },
  { ctx = { client_id = 100 }, action = { title = "Second code action" } },
}
local selected, selected_index, callbacks = nil, nil, 0
vim.ui.select(
  choices,
  { kind = "codeaction", prompt = "Code actions:" },
  function(item, index)
    callbacks = callbacks + 1
    selected, selected_index = item, index
  end
)
assert(package.loaded.telescope and vim.ui.select ~= selector)
local state = require("telescope.actions.state")
assert(vim.wait(1000, function()
  return state.get_selected_entry() ~= nil
end))
local prompt = vim.api.nvim_get_current_buf()
assert(
  vim.bo[prompt].filetype == "TelescopePrompt",
  "code actions must open a picker"
)
assert(
  vim.api.nvim_win_get_config(0).relative ~= "",
  "picker must use a floating window"
)
require("telescope.actions").select_default(prompt)
assert(vim.wait(1000, function()
  return callbacks == 1
end))
assert(selected == choices[1] and selected_index == 1)
local loaded_selector = vim.ui.select
vim.ui.select(choices, { kind = "codeaction" }, function(item, index)
  callbacks = callbacks + 1
  selected, selected_index = item, index
end)
assert(vim.wait(1000, function()
  return state.get_selected_entry() ~= nil
end))
require("telescope.actions").close(vim.api.nvim_get_current_buf())
assert(vim.wait(1000, function()
  return callbacks == 2
end))
assert(selected == nil and selected_index == nil)
assert(
  vim.ui.select == loaded_selector,
  "later selects must reuse the registered provider"
)
print(
  "PASS: first code-action select opens a modal; selection and cancellation work"
)
