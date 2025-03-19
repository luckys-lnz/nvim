-- lua/plugins/extras/lang/python.lua
-- Python specific configuration

return {
  -- Add Python specific language support
  {
    "neovim/nvim-lspconfig",
    opts = {
      servers = {
        pyright = {
          settings = {
            python = {
              analysis = {
                typeCheckingMode = "basic",
                diagnosticMode = "workspace",
                inlayHints = {
                  variableTypes = true,
                  functionReturnTypes = true,
                },
                useLibraryCodeForTypes = true,
                diagnosticSeverityOverrides = {
                  reportGeneralTypeIssues = "warning",
                  reportOptionalMemberAccess = "warning",
                  reportOptionalSubscript = "warning",
                  reportPrivateImportUsage = "warning",
                },
              },
            },
          },
        },
      },
    },
  },

  -- Python REPL integration
  {
    "michaelb/sniprun",
    branch = "master",
    build = "sh install.sh",
    cmd = { "SnipRun", "SnipInfo", "SnipReset", "SnipTerminate" },
    keys = {
      { "<leader>sr", "<cmd>SnipRun<cr>", desc = "SnipRun" },
      { "<leader>sr", "<Plug>SnipRun", mode = "v", desc = "SnipRun Selection" },
    },
    opts = {
      display = {
        "Classic",
        "VirtualTextOk",
        "VirtualTextErr",
      },
      live_display = { "VirtualTextOk" },
      display_options = {
        terminal_width = 45,
        notification_timeout = 5,
      },
      interpreter_options = {
        Python3_original = {
          interpreter = "python",
          venv = { "conda", "venv" },
        },
      },
    },
  },

  -- Python test runner
  {
    "nvim-neotest/neotest",
    dependencies = {
      "nvim-neotest/neotest-python",
    },
    opts = {
      adapters = {
        ["neotest-python"] = {
          -- Here you can specify the settings for the adapter, i.e.
          runner = "pytest",
          python = "python",
        },
      },
    },
  },

  -- Python code formatter
  {
    "stevearc/conform.nvim",
    opts = {
      formatters_by_ft = {
        python = { "isort", "black" },
      },
    },
  },
}

