return {
  "rcarriga/nvim-dap-ui",
  enabled = false,
  event = "VeryLazy",
  dependencies = {
    "mfussenegger/nvim-dap",
    "nvim-neotest/nvim-nio",
    "williamboman/mason.nvim",
    "jay-babu/mason-nvim-dap.nvim",
  },
  config = function()
    local mason_path = require("mason-core.path")
    local dap = require("dap")
    local dapui = require("dapui")
    local wk = require("which-key")

    -- dap.adapters.lldb = {
    --   type = "executable",
    --   command = mason_path.bin_prefix("codelldb"),
    --   name = "lldb",
    -- }

    dap.adapters.codelldb = {
      type = "server",
      host = "127.0.0.1",
      port = "13777",
      executable = {
        command = mason_path.bin_prefix("codelldb"),
        args = {
          "--port",
          "13777",
        },
      },
    }
    dapui.setup()
    dap.listeners.before.attach.dapui_config = function()
      dapui.open()
    end
    dap.listeners.before.launch.dapui_config = function()
      dapui.open()
    end
    dap.listeners.before.event_terminated.dapui_config = function()
      dapui.close()
    end
    dap.listeners.before.event_exited.dapui_config = function()
      dapui.close()
    end

    dap.configurations.cpp = {
      {
        name = "Launch",
        type = "codelldb",
        request = "launch",
        program = function()
          return vim.fn.input(
            "Path to executable: ",
            vim.fn.getcwd() .. "/",
            "file"
          )
        end,
        --program = '${fileDirname}/${fileBasenameNoExtension}',
        cwd = "${workspaceFolder}",
        stopOnEntry = false,
        args = {},
      },
    }

    wk.add({
      {
        "<leader>d",
        group = "Nvim Dap",
      },
      {
        "<leader>db",
        "<cmd>DapToggleBreakpoint<cr>",
        desc = "Toggle Breakpoint",
      },
      {
        "<leader>dr",
        "<cmd>DapContinue<cr>",
        desc = "Dap Continue",
      },
    })
  end,
}
