return {
  "armed/clojure-test.nvim",
  branch = "dev",
  dev = vim.env.NVIM_CLOJURE_TEST_DEV == "1",
  dir = vim.env.NVIM_CLOJURE_TEST_DEV == "1" and vim.fn.expand(
    "~/Developer/myself/clojure-test.nvim"
  ) or nil,

  ft = { "clojure" },

  dependencies = {
    { "nvim-neotest/nvim-nio" },
    { "MunifTanjim/nui.nvim" },
  },

  config = function()
    local clojure_test = require("clojure-test")
    local api = require("clojure-test.api")

    clojure_test.setup({
      layout = {
        style = "intellij",
      },
      hooks = {
        before_run = function()
          local u = require("config.plugins.conjure.util")

          if vim.bo.buftype == "" and vim.api.nvim_buf_get_name(0) ~= "" then
            vim.cmd("update")
          end
          u.conjure_eval("((requiring-resolve 'clj-reload.core/reload))")
        end,
      },
    })

    local function attach(bufnr)
      local function map(lhs, rhs, desc)
        vim.keymap.set("n", lhs, rhs, { buffer = bufnr, desc = desc })
      end
      map(
        "<localleader>tl",
        api.load_tests,
        "Find and load test namespaces in classpath"
      )
      map("<localleader>ta", api.run_all_tests, "Run all tests")
      map("<localleader>tr", api.run_tests, "Run tests")
      map(
        "<localleader>tn",
        api.run_tests_in_current_ns,
        "Run tests in a namespace"
      )
      map(
        "<localleader>tp",
        api.rerun_previous,
        "Rerun the most recently run tests"
      )
      map("<localleader>tf", api.rerun_failed, "Rerun failed tests")
      map("<localleader>ts", api.run_selected_tests, "Open test picker")
      map("<localleader>tt", api.toggle_panel, "Toggle test panel")
      map(
        "<localleader>to",
        api.open_last_report,
        "Re-open the previous report"
      )
      map("<localleader>!", function()
        api.analyze_exception("*e")
      end, "Inspect the most recent exception")
    end
    vim.api.nvim_create_autocmd("FileType", {
      group = vim.api.nvim_create_augroup(
        "ClojureTestMappings",
        { clear = true }
      ),
      pattern = "clojure",
      callback = function(args)
        attach(args.buf)
      end,
    })
    attach(vim.api.nvim_get_current_buf())
  end,
}
