# Neovim

Requires **Neovim 0.12+** for the pinned `nvim-treesitter` main branch, native
`vim.lsp.config` / `vim.lsp.enable`, and diagnostic virtual lines.

Link this directory to `~/.config/nvim`. Lazy bootstraps itself, installs plugins,
and preserves their versions in `lazy-lock.json`. Use `:Lazy restore` to restore
the pinned revisions; use `:Lazy update` deliberately to change them. Tree-sitter
installs the configured language parsers asynchronously; a missing parser does
not block editing. Parser builds require `curl`, a C compiler, and `tree-sitter`.

Language servers and formatters are external executables managed through mise or
project-local `node_modules`. Enabled servers: `clojure-lsp`, `lua-language-server`,
`rust-analyzer`, `typescript-language-server`, and JDTLS for Java. Formatting is
explicit via `<leader>lf`; JS/JSX/TS/TSX choose the first available Biome,
prettierd, or Prettier. Biome runs formatting only. `pruner` handles injected
languages; Markdown uses Conform's injected formatter.

Autosave keeps the existing BufLeave / FocusLost workflow for writable, named,
ordinary files. Rename, text-case selection, and file operations leave writes to
this workflow or explicit save commands. Clojure reload/tests save the current
source buffer before loading it.

## Project settings

- JDTLS: `vim.g.jdtls_home` defaults to
  `~/Developer/tools/jdt-language-server`; `vim.g.jdtls_java` defaults to the
  `java` executable on PATH. Set it to the Java version required by your JDTLS
  installation. Each canonical project root gets its own workspace under
  `stdpath("data")/jdtls/projects`. Clojure classpaths are gathered asynchronously,
  with a 30-second timeout, and cached per project for the editor session.
- Clojure LSP retains the farthest deps.edn / project.clj / bb.edn root.
  `kmono cp` is selected when that root contains `packages/` and kmono is available.
  Set `vim.g.clojure_lsp_use_kmono` to `true` or `false` to override this detection.
- `clojure-test.nvim` uses the published `armed/clojure-test.nvim` dev branch,
  pinned in the lock file. Set `NVIM_CLOJURE_TEST_DEV=1` to use the local checkout
  `~/Developer/myself/clojure-test.nvim` while developing the plugin.
- `:ClojureSplitCommentClosers` explicitly splits extra trailing closers from
  semicolon-commented code; accepts a line range. Ordinary typing never invokes
  this transformation. Portal tap uses the namespace of the current Clojure file.

Tree folder search/test shortcuts are local to tree buffers. Clojure REPL, Portal,
and test shortcuts are local to Clojure buffers; LSP shortcuts are attached per
buffer. Diagnostic virtual lines are also toggled per buffer.

## Checks

Run `./tests/run.sh` from this directory after installing the locked plugins and
the Clojure parser. The checks use `nvim -u NONE`, temporary fixtures and stubs:
no real LSP, REPL or user project is started. They cover comment/rename safety,
diagnostic isolation, Java project separation, formatter selection, Clojure
snippets and namespace parsing, asynchronous classpath/REPL discovery, and UI
state preservation, including large unsaved buffers and tree paths with spaces. Use `stylua --check <changed Lua files>` for formatting.

GUI clipboard behavior in Neovide, live Portal/test execution, and real language
server behavior still need interactive verification in the corresponding projects.
