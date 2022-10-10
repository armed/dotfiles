local M = {}

local function define_signs()
  local error = "DiagnosticSignError"
  local warn = "DiagnosticSignWarn"
  local info = "DiagnosticSignInfo"
  local hint = "DiagnosticSignHint"
  vim.fn.sign_define(error, { text = "", texthl = error })
  vim.fn.sign_define(warn, { text = "", texthl = warn })
  vim.fn.sign_define(info, { text = "", texthl = info })
  vim.fn.sign_define(hint, { text = "", texthl = hint })
end

function M.setup()
  local lspconfig = require("lspconfig")
  local tb = require("telescope.builtin")
  local cmplsp = require("cmp_nvim_lsp")
  local wk = require("which-key")

  define_signs()
  require("mason").setup()
  require("mason-lspconfig").setup({
    ensure_installed = { "clojure_lsp", "lua-language-server" }
  })

  local capabilities = cmplsp.update_capabilities(
    vim.lsp.protocol.make_client_capabilities())

  local handlers = {
    ["textDocument/publishDiagnostics"] = vim.lsp.with(
      vim.lsp.diagnostic.on_publish_diagnostics,
      {
        virtual_text = true,
        signs = true,
        underline = true,
        severity_sort = true,
        update_in_insert = false
      }
    ),
    ["textDocument/codeLens"] = vim.lsp.with(
      vim.lsp.diagnostic.on_publish_diagnostics,
      { virtual_text = true }
    ),
    ["textDocument/hover"] = vim.lsp.with(
      vim.lsp.handlers.hover,
      { border = "double" }
    ),
    ["textDocument/signatureHelp"] = vim.lsp.with(
      vim.lsp.handlers.signature_help,
      { border = "single" }
    )
  }

  local bindings = {
    g = {
      d = { tb.lsp_definitions, "Go to definition" },
      r = { tb.lsp_references, "LSP rerefences" },
      t = { tb.lsp_type_definitions, "Type definition" }
    },
    ["<leader>"] = {
      l = {
        r = { vim.lsp.buf.rename, "Rename" },
        a = { vim.lsp.buf.code_action, "Code actions" },
        s = { tb.lsp_document_symbols, "Document symbols" },
        S = { tb.lsp_dynamic_workspace_symbols, "Workspace symbols" },
        f = { vim.lsp.buf.format, "Format buffer" },
        d = { tb.diagnostics, "Document diagnostics" },
        R = { ":LspRestart<cr>", "Restart LSP" }
      }
    },
    K = { vim.lsp.buf.hover, "Hover doc" }
  }

  local function on_attach(_, bufnr)
    return wk.register(bindings, { noremap = true, buffer = bufnr })
  end

  require("mason-lspconfig").setup_handlers({
    function(server_name) -- default handler (optional)
      require("lspconfig")[server_name].setup {
        on_attach = on_attach,
        -- capabilities = capabilities,
        handlers = handlers
      }
    end,

    ["sumneko_lua"] = function()
      lspconfig.sumneko_lua.setup {
        on_attach = on_attach,
        handlers = handlers,
        -- capabilities = capabilities,
        settings = {
          Lua = {
            runtime = {
              -- Tell the language server which version of Lua you're using (most likely LuaJIT in the case of Neovim)
              version = "LuaJIT",
              -- Setup your lua path
              path = vim.split(package.path, ";"),
            },
            diagnostics = {
              -- Get the language server to recognize the `vim` global
              globals = { "vim", "describe", "it", "before_each", "after_each", "packer_plugins" },
              -- disable = { "lowercase-global", "undefined-global", "unused-local", "unused-vararg", "trailing-space" },
            },
            workspace = {
              -- Make the server aware of Neovim runtime files
              library = {
                [vim.fn.expand "$VIMRUNTIME/lua"] = true,
                [vim.fn.expand "$VIMRUNTIME/lua/vim/lsp"] = true,
              },
              -- library = vim.api.nvim_get_runtime_file("", true),
              maxPreload = 1000,
              preloadFileSize = 50000,
              ignoreDir = {"share", "plugin", "data", "cache"}
            },
            completion = { callSnippet = "Both" },
            telemetry = { enable = false },
            hint = {
              enable = true,
            },
          },
        },
      }
    end,

    ["clojure_lsp"] = function()
      lspconfig.clojure_lsp.setup {
        on_attach = on_attach,
        -- capabilities = capabilities,
        handlers = handlers,
        init_options = { signatureHelp = true, codeLens = true },
        -- cmd = { "/usr/local/bin/clojure-lsp" },
      }
    end
  })
end

return M
