local M = {}

function M.get_config(_servers, options)
  return function()
    local tools_config = require("typescript-tools.config")
    local file_settings =
      tools_config.get_tsserver_file_preferences(vim.opt.filetype)
    local format_opts = tools_config.default_format_options
    local ts_settings = {
      settings = {
        tsserver_file_preferences = vim.tbl_deep_extend(
          "force",
          file_settings,
          {
            includeInlayParameterNameHints = "all",
            includeInlayParameterNameHintsWhenArgumentMatchesName = true,
            includeInlayFunctionParameterTypeHints = true,
            includeInlayVariableTypeHints = true,
            includeInlayVariableTypeHintsWhenTypeMatchesName = true,
            includeInlayPropertyDeclarationTypeHints = true,
            includeInlayFunctionLikeReturnTypeHints = true,
            includeInlayEnumMemberValueHints = true,
          }
        ),
        tsserver_format_options = format_opts,
      },
    }
    require("typescript-tools").setup(
      vim.tbl_deep_extend("force", options, ts_settings)
    )
  end
end

return M
