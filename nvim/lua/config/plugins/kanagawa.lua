return {
  "rebelot/kanagawa.nvim",
  priority = 1000,
  config = function()
    local theme = require("kanagawa")

    theme.setup({
      dimInactive = true,
      commentStyle = {
        italic = false,
      },
      colors = {
        theme = {
          all = {
            ui = {
              bg_gutter = "none",
            },
          },
        },
      },
      keywordStyle = {
        italic = false,
      },
      globalStatus = true,
      overrides = function(colors)
        local palette = colors.palette

        vim.api.nvim_set_hl(0, "user.win.title", {
          bg = palette.crystalBlue,
          fg = palette.dragonBlack1,
        })

        return {
          WinSeparator = {
            fg = palette.lotusOrange2,
            bg = palette.bg_dim or "NONE",
          },
          IndentBlanklineChar = { fg = palette.bg_light2 },
          IndentBlanklineSpaceChar = { fg = palette.bg_light2 },
          IndentBlanklineSpaceCharBlankline = { fg = palette.bg_light2 },
          IndentBlanklineContextChar = { fg = palette.bg_light3 },
          IndentBlanklineContextStart = {
            sp = palette.bg_light3,
            underline = true,
          },
          ["@lsp.type.class"] = { link = "Structure" },
          ["@lsp.type.decorator"] = { link = "Function" },
          ["@lsp.type.enum"] = { link = "Structure" },
          ["@lsp.type.enumMember"] = { link = "Constant" },
          ["@lsp.type.function"] = { link = "Function" },
          ["@lsp.type.interface"] = { link = "Structure" },
          ["@lsp.type.macro"] = { link = "Macro" },
          ["@lsp.type.method"] = { link = "@function.method" }, -- Function
          ["@lsp.type.namespace"] = { link = "@module" }, -- Structure
          ["@lsp.type.parameter"] = { link = "@variable.parameter" }, -- Identifier
          ["@lsp.type.property"] = { link = "Identifier" },
          ["@lsp.type.struct"] = { link = "Structure" },
          ["@lsp.type.type"] = { link = "Type" },
          ["@lsp.type.typeParameter"] = { link = "TypeDef" },
          ["@lsp.type.variable"] = { fg = "none" }, -- Identifier
          ["@lsp.type.comment"] = { fg = "none" }, -- Comment

          ["@lsp.type.selfParameter"] = { link = "@variable.builtin" },
          ["@lsp.type.builtinConstant"] = { link = "@constant.builtin" },
          ["@lsp.type.magicFunction"] = { link = "@function.builtin" },

          ["@lsp.mod.readonly"] = { link = "Constant" },
          ["@lsp.mod.typeHint"] = { link = "Type" },
          ["@lsp.mod.defaultLibrary"] = { link = "Special" },
          ["@lsp.mod.builtin"] = { link = "Special" },

          ["@lsp.typemod.operator.controlFlow"] = {
            link = "@keyword.exception",
          },
          ["@lsp.typemod.keyword.documentation"] = { link = "Special" },

          ["@lsp.typemod.variable.global"] = { link = "Constant" },
          ["@lsp.typemod.variable.static"] = { link = "Constant" },
          ["@lsp.typemod.variable.defaultLibrary"] = { link = "Special" },

          ["@lsp.typemod.function.builtin"] = { link = "@function.builtin" },
          ["@lsp.typemod.function.defaultLibrary"] = {
            link = "@function.builtin",
          },
          ["@lsp.typemod.method.defaultLibrary"] = {
            link = "@function.builtin",
          },

          ["@lsp.typemod.operator.injected"] = { link = "Operator" },
          ["@lsp.typemod.string.injected"] = { link = "String" },
          ["@lsp.typemod.variable.injected"] = { link = "@variable" },
        }
      end,
    })
  end,
}
