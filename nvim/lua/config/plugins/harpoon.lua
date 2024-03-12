return {
  "ThePrimeagen/harpoon",
  branch = "harpoon2",
  keys = {
    { "<leader>b", desc = "Harpoon" },
  },
  dependencies = {
    "nvim-telescope/telescope.nvim",
    "nvim-lua/plenary.nvim",
  },
  config = function()
    local h = require("harpoon")
    local wk = require("which-key")
    local conf = require("telescope.config").values

    h:setup({
      settings = {
        save_on_toggle = true,
      },
    })

    local function toggle_telescope(harpoon_files)
      local file_paths = {}
      for _, item in ipairs(harpoon_files.items) do
        table.insert(file_paths, item.value)
      end

      require("telescope.pickers")
        .new({}, {
          prompt_title = "Harpoon",
          finder = require("telescope.finders").new_table({
            results = file_paths,
          }),
          previewer = conf.file_previewer({}),
          sorter = conf.generic_sorter({}),
        })
        :find()
    end

    wk.register({
      b = {
        a = {
          function()
            h:list():append()
          end,
          "Mark File",
        },
        b = {
          function()
            h.ui:toggle_quick_menu(h:list())
          end,
          "Harpoon",
        },
        f = {
          function()
            toggle_telescope(h:list())
          end,
          "Menu",
        },
        ["1"] = {
          function()
            h:list():select(1)
          end,
          "Select 1",
        },
        ["2"] = {
          function()
            h:list():select(2)
          end,
          "Select 2",
        },
        ["3"] = {
          function()
            h:list():select(3)
          end,
          "Select 3",
        },
        ["4"] = {
          function()
            h:list():select(4)
          end,
          "Select 4",
        },
        l = {
          function()
            h:list():next()
          end,
          "Next File",
        },
        h = {
          function()
            h:list():prev()
          end,
          "Prev File",
        },
      },
    }, { prefix = "<leader>" })
  end,
}
