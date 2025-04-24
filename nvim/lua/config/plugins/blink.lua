return {
  "saghen/blink.cmp",
  event = "InsertEnter",
  dependencies = {
    -- "mikavilpas/blink-ripgrep.nvim",
    {
      "L3MON4D3/LuaSnip",
      version = "v2.*",
      build = "make install_jsregexp",
      dependencies = {
        "rafamadriz/friendly-snippets",
      },
      config = function()
        require("luasnip.loaders.from_vscode").lazy_load()
        require("luasnip.loaders.from_snipmate").lazy_load({
          paths = { vim.fn.stdpath("config") .. "/snippets" },
        })
        local extends = {
          javascript = { "jsdoc" },
          lua = { "luadoc" },
          rust = { "rustdoc" },
          java = { "javadoc" },
          sh = { "shelldoc" },
        }
        -- friendly-snippets - enable standardized comments snippets
        for ft, snips in pairs(extends) do
          require("luasnip").filetype_extend(ft, snips)
        end
      end,
      opts = { history = true, delete_check_events = "TextChanged" },
    },
  },

  version = "1.*",

  ---@module 'blink.cmp'
  ---@type blink.cmp.Config
  opts = {
    enabled = function()
      local disabled = false
      local success, node = pcall(vim.treesitter.get_node)
      disabled = disabled or (vim.bo.buftype == "prompt")
      disabled = disabled or (vim.fn.reg_recording() ~= "")
      disabled = disabled or (vim.fn.reg_executing() ~= "")
      disabled = disabled
        or (
          success
          and node ~= nil
          and vim.tbl_contains(
            { "comment", "line_comment", "block_comment" },
            node:type()
          )
        )

      return not disabled
    end,
    keymap = {
      preset = "default",
      ["<S-Tab>"] = { "select_prev", "fallback" },
      ["<Tab>"] = { "select_next", "fallback" },
      ["<CR>"] = { "accept", "fallback" },
    },

    appearance = {
      nerd_font_variant = "mono",
    },

    completion = {
      documentation = {
        auto_show = true,
        auto_show_delay_ms = 200,
        window = {
          border = "single",
          winhighlight = "Normal:Normal,FloatBorder:FloatBorder,CursorLine:BlinkCmpDocCursorLine,Search:None",
        },
      },
      menu = {
        border = "single",
        draw = { gap = 1 },
        winhighlight = "Normal:Normal,FloatBorder:FloatBorder,CursorLine:BlinkCmpMenuSelection,Search:None",
      },
    },
    snippets = { preset = "luasnip" },
    sources = {
      default = { "lsp", "path", "snippets", "buffer" },
    },

    fuzzy = {
      implementation = "prefer_rust_with_warning",
      use_frecency = false,
      use_proximity = false,
      sorts = { "exact", "score", "sort_text" },
    },
    signature = { enabled = true },
  },
  opts_extend = { "sources.default" },
}
