local utils = require("config.lsp.utils")

local farthest_parent = { "/deps.edn", "/project.clj", "/bb.edn" }
local root_finder = utils.make_lsp_root_finder(farthest_parent)

---@type vim.lsp.Config
return {
  root_dir = root_finder,
  cmd = { "clojure-lsp" },
  filetypes = { "clojure" },
  single_file_support = true,
  init_options = {
    codeLens = true,
    signatureHelp = true,
  },
  before_init = function(params, config)
    local root = config.root_dir
    local use_kmono = vim.g.clojure_lsp_use_kmono
    if use_kmono == nil then
      use_kmono = root and vim.fn.isdirectory(root .. "/packages") == 1
    end
    if use_kmono and vim.fn.executable("kmono") == 1 then
      config.init_options["project-specs"] = {
        {
          ["project-path"] = "deps.edn",
          ["classpath-cmd"] = { "kmono", "cp" },
        },
      }
    end
    params.workDoneToken = "enable-progress"
  end,
}
