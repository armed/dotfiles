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

    wk.add({
      {
        "<leader>b1",
        function()
          h:list():select(1)
        end,
        desc = "Select 1",
      },
      {
        "<leader>b2",
        function()
          h:list():select(2)
        end,
        desc = "Select 2",
      },
      {
        "<leader>b3",
        function()
          h:list():select(3)
        end,
        desc = "Select 3",
      },
      {
        "<leader>b4",
        function()
          h:list():select(4)
        end,
        desc = "Select 4",
      },
      {
        "<leader>ba",
        function()
          h:list():append()
        end,
        desc = "Mark File",
      },
      {
        "<leader>bb",
        function()
          h.ui:toggle_quick_menu(h:list())
        end,
        desc = "Harpoon",
      },
      {
        "<leader>bf",
        function()
          toggle_telescope(h:list())
        end,
        desc = "Menu",
      },
      {
        "<leader>bh",
        function()
          h:list():prev()
        end,
        desc = "Prev File",
      },
      {
        "<leader>bl",
        function()
          h:list():next()
        end,
        desc = "Next File",
      },
    })
  end,
}
