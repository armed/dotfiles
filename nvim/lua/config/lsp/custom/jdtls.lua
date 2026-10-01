local M = {}
local libraries = {}
local pending = {}

local function project_root(bufnr)
  local name = vim.api.nvim_buf_get_name(bufnr)
  if name == "" then
    return nil
  end
  local root = vim.fs.root(bufnr, {
    {
      "mvnw",
      "gradlew",
      "pom.xml",
      "build.gradle",
      "build.gradle.kts",
      "deps.edn",
    },
    ".git",
  }) or vim.fs.dirname(name)
  return vim.uv.fs_realpath(root) or root
end

local function config_for(root, libs)
  local common = require("config.common.utils")
  local home = vim.g.jdtls_home
    or common.home_dir .. "/Developer/tools/jdt-language-server"
  local java = vim.g.jdtls_java or vim.fn.exepath("java")
  local uname = vim.uv.os_uname()
  local platform = vim.fn.has("mac") == 1 and "mac"
    or vim.fn.has("win32") == 1 and "win"
    or "linux"
  local arm = uname.machine == "arm64" or uname.machine == "aarch64"
  local config_dir = home
    .. "/config_"
    .. platform
    .. (arm and platform ~= "win" and "_arm" or "")
  local launcher = common.find_file_by_glob(
    home .. "/plugins",
    "org.eclipse.equinox.launcher_*.jar"
  )
  if
    not launcher
    or vim.fn.executable(java) ~= 1
    or vim.fn.isdirectory(config_dir) ~= 1
  then
    vim.notify(
      "JDTLS: check g:jdtls_home, g:jdtls_java and the platform configuration",
      vim.log.levels.WARN
    )
    return nil
  end
  local jdtls = require("jdtls")
  return {
    cmd = {
      java,
      "-Declipse.application=org.eclipse.jdt.ls.core.id1",
      "-Dosgi.bundles.defaultStartLevel=4",
      "-Declipse.product=org.eclipse.jdt.ls.core.product",
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
      config_dir,
      "-data",
      vim.fn.stdpath("data") .. "/jdtls/projects/" .. vim.fn.sha256(root),
    },
    root_dir = root,
    capabilities = vim.deepcopy(vim.lsp.config["*"].capabilities),
    settings = {
      java = {
        signatureHelp = { enabled = true },
        contentProvider = { preferred = "fernflower" },
        project = { referencedLibraries = libs },
      },
    },
    init_options = {
      extendedClientCapabilities = vim.tbl_extend(
        "force",
        {},
        jdtls.extendedClientCapabilities,
        { resolveAdditionalTextEditsSupport = true }
      ),
    },
  }
end

function M.start(bufnr)
  bufnr = bufnr or vim.api.nvim_get_current_buf()
  if
    not vim.api.nvim_buf_is_valid(bufnr) or vim.bo[bufnr].filetype ~= "java"
  then
    return
  end
  local root = project_root(bufnr)
  if not root or pending[bufnr] == root then
    return
  end
  pending[bufnr] = root
  local function attach(libs)
    if pending[bufnr] ~= root then
      return
    end
    pending[bufnr] = nil
    if
      not vim.api.nvim_buf_is_valid(bufnr)
      or vim.bo[bufnr].filetype ~= "java"
      or project_root(bufnr) ~= root
    then
      return
    end
    local config = config_for(root, libs)
    if config then
      vim.api.nvim_buf_call(bufnr, function()
        require("jdtls").start_or_attach(config)
      end)
    end
  end
  -- Share work across buffers without blocking FileType or capturing the current buffer.
  if libraries[root] then
    if libraries[root].value then
      attach(libraries[root].value)
    else
      table.insert(libraries[root].callbacks, attach)
    end
    return
  end
  libraries[root] = { callbacks = { attach } }
  require("config.common.utils").find_third_party_libs(root, function(libs)
    local callbacks = libraries[root].callbacks
    libraries[root] = { value = libs }
    for _, callback in ipairs(callbacks) do
      callback(libs)
    end
  end)
end

function M.setup()
  local group = vim.api.nvim_create_augroup("JavaLsp", { clear = true })
  vim.api.nvim_create_autocmd("FileType", {
    group = group,
    pattern = "java",
    callback = function(args)
      M.start(args.buf)
    end,
  })
  M.start()
end

return M
