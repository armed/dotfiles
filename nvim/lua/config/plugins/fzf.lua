return {
  "ibhagwan/fzf-lua",
  cmd = "FzfLua",
  dependencies = {
    "kyazdani42/nvim-web-devicons",
  },
  config = function()
    local actions = require("fzf-lua.actions")
    local fzf = require("fzf-lua")
    fzf.setup({
      -- "telescope",
      files = {
        -- previewer = "bat",
        -- path_shorten = true,
        fd_opts = "--type f "
          .. "--no-ignore "
          .. "-E '.git/*' "
          .. "-E 'gen/*' "
          .. "-E '.shadow-cljs/*' "
          .. "-E '.cache/*' "
          .. "-E '.DS_Store/*' "
          .. "-E 'node_modules' "
          .. "-E '*.log' "
          .. "-E '.classes' "
          .. "-E '*.class' "
          .. "-E '.cpcache' "
          .. "-E 'target' "
          .. "-E '*-lock.*' "
          .. "-E 'cache/*' ",
      },
      oldfiles = {
        cwd_only = true,
      },
      previewers = {
        bat = {
          theme = "Coldark-Dark",
        },
      },
      keymap = {
        -- These override the default tables completely
        -- no need to set to `false` to disable a bind
        -- delete or modify is sufficient
        builtin = {
          -- neovim `:tmap` mappings for the fzf win
          ["<F1>"] = "toggle-help",
          ["<F2>"] = "toggle-fullscreen",
          -- Only valid with the 'builtin' previewer
          ["<F3>"] = "toggle-preview-wrap",
          ["<F4>"] = "toggle-preview",
          -- Rotate preview clockwise/counter-clockwise
          ["<F5>"] = "toggle-preview-ccw",
          ["<F6>"] = "toggle-preview-cw",
          ["<S-down>"] = "preview-page-down",
          ["<S-up>"] = "preview-page-up",
          ["<S-left>"] = "preview-page-reset",
        },
        fzf = {
          -- fzf '--bind=' options
          ["ctrl-z"] = "abort",
          ["ctrl-u"] = "unix-line-discard",
          ["ctrl-f"] = "half-page-down",
          ["ctrl-b"] = "half-page-up",
          ["ctrl-a"] = "beginning-of-line",
          ["ctrl-e"] = "end-of-line",
          ["alt-a"] = "toggle-all",
          -- Only valid with fzf previewers (bat/cat/git/etc)
          ["f3"] = "toggle-preview-wrap",
          ["f4"] = "toggle-preview",
          ["shift-down"] = "preview-page-down",
          ["shift-up"] = "preview-page-up",
        },
      },
      actions = {
        -- These override the default tables completely
        -- no need to set to `false` to disable an action
        -- delete or modify is sufficient
        files = {
          -- providers that inherit these actions:
          --   files, git_files, git_status, grep, lsp
          --   oldfiles, quickfix, loclist, tags, btags
          --   args
          -- default action opens a single selection
          -- or sends multiple selection to quickfix
          -- replace the default action with the below
          -- to open all files whether single or multiple
          -- ["default"]     = actions.file_edit,
          ["default"] = actions.file_edit_or_qf,
          ["ctrl-s"] = actions.file_split,
          ["ctrl-v"] = actions.file_vsplit,
          ["ctrl-t"] = actions.file_tabedit,
          ["alt-q"] = actions.file_sel_to_qf,
          ["alt-l"] = actions.file_sel_to_ll,
        },
        buffers = {
          -- providers that inherit these actions:
          --   buffers, tabs, lines, blines
          ["default"] = actions.buf_edit,
          ["ctrl-s"] = actions.buf_split,
          ["ctrl-v"] = actions.buf_vsplit,
          ["ctrl-t"] = actions.buf_tabedit,
        },
      },
      grep = {
        -- debug = true,
        prompt = "Rg❯ ",
        input_prompt = "Grep For❯ ",
        multiprocess = true, -- run command in a separate process
        git_icons = true, -- show git icons?
        file_icons = true, -- show file icons?
        color_icons = true, -- colorize file|git icons
        -- executed command priority is 'cmd' (if exists)
        -- otherwise auto-detect prioritizes `rg` over `grep`
        -- default options are controlled by 'rg|grep_opts'
        -- grep_opts = "--binary-files=without-match --line-number --recursive --color=auto --perl-regexp",
        -- cmd = "rg",
        rg_opts =         -- search all known types
        -- "--type=all "
"-g='!{.git,**/node_modules,**/.cache,**/.cpcache,**/tmp,**/target,**/.shadow-cljs}/*' "
          .. "-g='!{*.log,*-lock.*}' "
          -- limit of sin lines longer than 150 is not relevan t
          .. "--max-columns=150 "
          .. "--hidden "
          .. "--no-ignore-vcs "
          .. "--color=never "
          .. "--no-heading "
          .. "--with-filename "
          .. "--line-number "
          .. "--column "
          .. "--smart-case "
          .. "--trim ",
        -- set to 'true' to always parse globs in both 'grep' and 'live_grep'
        -- search strings will be split using the 'glob_separator' and translated
        -- to '--iglob=' arguments, requires 'rg'
        -- can still be used when 'false' by calling 'live_grep_glob' directly
        rg_glob = false, -- default to glob parsing?
        glob_flag = "--iglob", -- for case sensitive globs use '--glob'
        glob_separator = "%s%-%-", -- query separator pattern (lua): ' --'
        -- advanced usage: for custom argument parsing define
        -- 'rg_glob_fn' to return a pair:
        --   first returned argument is the new search query
        --   second returned argument are addtional rg flags
        -- rg_glob_fn = function(query, opts)
        --   ...
        --   return new_query, flags
        -- end,
        actions = {
          -- actions inherit from 'actions.files' and merge
          -- this action toggles between 'grep' and 'live_grep'
          ["ctrl-g"] = { actions.grep_lgrep },
        },
        no_header = false, -- hide grep|cwd header?
        no_header_i = false, -- hide interactive header?
      },
    })
  end,
}
