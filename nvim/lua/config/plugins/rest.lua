return {
  "rest-nvim/rest.nvim",
  ft = "http",
  opts = {
    -- Open request results in a horizontal split
    result_split_horizontal = false,
    -- Keep the http file buffer above|left when split horizontal|vertical
    result_split_in_place = false,
    -- Skip SSL verification, useful for unknown certificates
    skip_ssl_verification = false,
    -- Encode URL before making request
    encode_url = true,
    -- Highlight request on run
    highlight = {
      enabled = true,
      timeout = 150,
    },
    result = {
      -- toggle showing URL, HTTP info, headers at top the of result window
      show_url = true,
      show_http_info = true,
      show_headers = true,
      -- executables or functions for formatting response body [optional]
      -- set them to false if you want to disable them
      formatters = {
        json = "jq",
        html = function(body)
          return vim.fn.system({ "tidy", "-i", "-q", "-" }, body)
        end,
      },
    },
    -- Jump to request line on run
    jump_to_request = false,
    env_file = ".env",
    custom_dynamic_variables = {},
    yank_dry_run = true,
  },
  config = function(conf)
    print(vim.inspect(conf.opts))
    require("rest-nvim").setup(conf.opts)
    local map = vim.keymap.set
    local autocmd = vim.api.nvim_create_autocmd
    local augroup = vim.api.nvim_create_augroup
    local rest = augroup("Rest Client", { clear = true })

    autocmd("FileType", {
      group = rest,
      pattern = { "http" },
      callback = function(event)
        local buf = event.buf
        map("n", "<leader>Rr", "<Plug>RestNvim",
          { desc = "Run under cursor", buffer = buf })
        map("n", "<leader>Rl", "<Plug>RestNvimLast",
          { desc = "Run last", buffer = buf })
        map("n", "<leader>Rv", "<Plug>RestNvimPreview",
          { desc = "Curl preview", buffer = buf })
      end,
    })
  end,
}
