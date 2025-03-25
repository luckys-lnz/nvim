-- lua/plugins/extras/test.lua
-- Testing framework integration

return {
  -- Testing framework
  {
    "nvim-neotest/neotest",
    dependencies = {
      "nvim-lua/plenary.nvim",
      "nvim-treesitter/nvim-treesitter",
      "antoinemadec/FixCursorHold.nvim",
      "nvim-neotest/neotest-python",
      "nvim-neotest/neotest-go",
      "rouge8/neotest-rust",
      "haydenmeade/neotest-jest",
    },
    keys = {
      { "<leader>tt", function() require("neotest").run.run() end, desc = "Run nearest test" },
      { "<leader>tf", function() require("neotest").run.run(vim.fn.expand("%")) end, desc = "Run current file" },
      { "<leader>td", function() require("neotest").run.run({ strategy = "dap" }) end, desc = "Debug nearest test" },
      { "<leader>ts", function() require("neotest").run.stop() end, desc = "Stop test" },
      { "<leader>ta", function() require("neotest").run.attach() end, desc = "Attach to test" },
      { "<leader>to", function() require("neotest").output.open({ enter = true }) end, desc = "Open test output" },
      { "<leader>tO", function() require("neotest").output_panel.toggle() end, desc = "Toggle test output panel" },
      { "<leader>tS", function() require("neotest").summary.toggle() end, desc = "Toggle test summary" },
    },
    opts = function()
      return {
        adapters = {
          require("neotest-python")({
            dap = { justMyCode = false },
            runner = "pytest",
          }),
          require("neotest-go"),
          require("neotest-rust"),
          require("neotest-jest")({
            jestCommand = "npm test --",
            jestConfigFile = "jest.config.js",
            env = { CI = true },
            cwd = function()
              return vim.fn.getcwd()
            end,
          }),
        },
        icons = {
          expanded = "",
          child_prefix = "",
          child_indent = "",
          final_child_prefix = "",
          non_collapsible = "",
          collapsed = "",
          passed = "✅",
          running = "🔄",
          failed = "❌",
          unknown = "❓",
        },
        status = {
          virtual_text = true,
          signs = true,
        },
        strategies = {
          integrated = {
            width = 180,
          },
        },
        summary = {
          open = "botright vsplit | vertical resize 60",
        },
        output = {
          open_on_run = true,
        },
        quickfix = {
          open = false,
        },
        consumers = {
          overseer = require("neotest.consumers.overseer"),
        },
        overseer = {
          enabled = true,
          force_default = true,
        },
      }
    end,
    config = function(_, opts)
      require("neotest").setup(opts)
    end,
  },
}

