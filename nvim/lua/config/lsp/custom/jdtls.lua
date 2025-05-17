local java_distribution = "temurin-23.0.2+7"

local settings = {
  settings = {
    single_file_support = true,
    java = {
      signatureHelp = { enabled = true },
      contentProvider = { preferred = "fernflower" },
    },
  },
}

local M = {}

M.setup = function()
  local jdtls = require("jdtls")
  local commons = require("config.common.utils")

  local jdtls_install_dir =
    vim.fn.expand("$HOME/Developer/tools/jdt-language-server")

  local config_dir = "config_mac_arm"
  if vim.fn.has("linux") == 1 then
    config_dir = "config_linux"
  end

  local home_dir = os.getenv("HOME")
  ---@diagnostic disable-next-line: param-type-mismatch
  local project_id = vim.fn.sha256(vim.fn.getcwd())
  local data_dir = home_dir
    .. "/.local/share/nvim/jdtls/projects/"
    .. project_id

  local launcher = commons.find_file_by_glob(
    jdtls_install_dir .. "/plugins",
    "org.eclipse.equinox.launcher_*"
  )

  local cmd = {
    commons.mise_install_path("/java/" .. java_distribution .. "/bin/java"),

    "-Declipse.application=org.eclipse.jdt.ls.core.id1",
    "-Dosgi.bundles.defaultStartLevel=4",
    "-Declipse.product=org.eclipse.jdt.ls.core.product",
    "-Dlog.protocol=true",
    "-Dlog.level=ALL",
    "-Xmx1g",
    "--add-modules=ALL-SYSTEM",
    "--enable-native-access=ALL-UNNAMED",
    "--add-opens",
    "java.base/java.util=ALL-UNNAMED",
    "--add-opens",
    "java.base/java.lang=ALL-UNNAMED",

    "-jar",
    launcher,

    "-configuration",
    jdtls_install_dir .. "/" .. config_dir,

    "-data",
    data_dir,
  }

  local libs = {}
  local current_file_dir = vim.fn.expand("%:p:h")
  local project_root = commons.find_furthest_root({ "mvnw" })(current_file_dir)
  local job_id = nil
  if project_root then
    job_id = commons.find_third_party_libs(project_root, function(project_libs)
      libs = project_libs
    end)
  end

  local extendedClientCapabilities = require("jdtls").extendedClientCapabilities
  local config = vim.tbl_deep_extend("force", settings, {
    cmd = cmd,
    root_dir = require("jdtls.setup").find_root({
      ".git",
      "mvnw",
      "gradlew",
      "pom.xml",
      "build.gradle",
    }),
    init_options = {
      extendedClientCapabilities = vim.tbl_deep_extend(
        "force",
        {},
        extendedClientCapabilities,
        {
          resolveAdditionalTextEditsSupport = true,
        }
      ),
    },
  })

  vim.api.nvim_create_autocmd("FileType", {
    pattern = { "java" },
    desc = "Start and attach jdtls",
    callback = function()
      if job_id then
        vim.fn.jobwait({ job_id })
        job_id = nil
      end
      local cfg = vim.tbl_deep_extend("force", {}, config, {
        settings = {
          java = {
            project = {
              referencedLibraries = libs,
            },
          },
        },
      })
      jdtls.start_or_attach(cfg or {})
    end,
  })
end

return M
