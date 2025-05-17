local utils = require("config.lsp.utils")

local farthest_parent = { "/deps.edn", "/project.clj", "/bb.edn" }
local root_finder = utils.make_lsp_root_finder(farthest_parent)

---@type vim.lsp.Config
return {
  root_dir = root_finder,
  cmd = { "clojure-lsp" },
  filetypes = { "clojure", "edn" },
  single_file_support = true,
  init_options = {
    codeLens = true,
    signatureHelp = true,
    ["project-specs"] = {
      {
        ["project-path"] = "deps.edn",
        ["classpath-cmd"] = { "kmono", "cp" },
      },
    },
  },
  before_init = function(params)
    params.workDoneToken = "enable-progress"
  end,
}
