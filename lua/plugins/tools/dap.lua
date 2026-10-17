-- Debugger (VS Code Run & Debug).  Same F-keys as VS Code:
--   F5 start/continue · Shift+F5 stop · F9 breakpoint · F10 step over
--   F11 step into · Shift+F11 step out · <Space>d… for everything else
--
-- A project's .vscode/launch.json is picked up automatically by nvim-dap.
-- Language files register adapters with: opts = { setup = { name = function(dap) … end } }

return {
	{
		"mfussenegger/nvim-dap",
		dependencies = {
			{
				"rcarriga/nvim-dap-ui",
				dependencies = { "nvim-neotest/nvim-nio" },
				-- stylua: ignore
				keys = {
					{ "<leader>du", function() require("dapui").toggle() end, desc = "Debugger UI (toggle)" },
					{ "<leader>de", function() require("dapui").eval() end, desc = "Evaluate expression", mode = { "n", "x" } },
				},
				opts = {},
				config = function(_, opts)
					local dap, dapui = require("dap"), require("dapui")
					dapui.setup(opts)
					dap.listeners.after.event_initialized.dapui_config = function() dapui.open({}) end
					dap.listeners.before.event_terminated.dapui_config = function() dapui.close({}) end
					dap.listeners.before.event_exited.dapui_config = function() dapui.close({}) end
				end,
			},
			{ "theHamsta/nvim-dap-virtual-text", opts = {} }, -- variable values inline
			{ "WhoIsSethDaniel/mason-tool-installer.nvim" },
		},
		-- stylua: ignore
		keys = {
			{ "<F5>",       function() require("dap").continue() end,          desc = "Debug: start / continue" },
			{ "<S-F5>",     function() require("dap").terminate() end,         desc = "Debug: stop" },
			{ "<F17>",      function() require("dap").terminate() end,         desc = "which_key_ignore" }, -- Shift+F5 in many terminals
			{ "<F9>",       function() require("dap").toggle_breakpoint() end, desc = "Debug: toggle breakpoint" },
			{ "<F10>",      function() require("dap").step_over() end,         desc = "Debug: step over" },
			{ "<F11>",      function() require("dap").step_into() end,         desc = "Debug: step into" },
			{ "<S-F11>",    function() require("dap").step_out() end,          desc = "Debug: step out" },
			{ "<F23>",      function() require("dap").step_out() end,          desc = "which_key_ignore" }, -- Shift+F11 in many terminals
			{ "<leader>db", function() require("dap").toggle_breakpoint() end, desc = "Toggle breakpoint" },
			{ "<leader>dB", function() require("dap").set_breakpoint(vim.fn.input("Condition: ")) end, desc = "Conditional breakpoint" },
			{ "<leader>dL", function() require("dap").set_breakpoint(nil, nil, vim.fn.input("Log message: ")) end, desc = "Log point" },
			{ "<leader>dc", function() require("dap").continue() end,          desc = "Start / continue" },
			{ "<leader>dC", function() require("dap").run_to_cursor() end,     desc = "Run to cursor" },
			{ "<leader>di", function() require("dap").step_into() end,         desc = "Step into" },
			{ "<leader>do", function() require("dap").step_over() end,         desc = "Step over" },
			{ "<leader>dO", function() require("dap").step_out() end,          desc = "Step out" },
			{ "<leader>dj", function() require("dap").down() end,              desc = "Down the stack" },
			{ "<leader>dk", function() require("dap").up() end,                desc = "Up the stack" },
			{ "<leader>dl", function() require("dap").run_last() end,          desc = "Run last config" },
			{ "<leader>dp", function() require("dap").pause() end,             desc = "Pause" },
			{ "<leader>dr", function() require("dap").repl.toggle() end,       desc = "REPL (toggle)" },
			{ "<leader>dt", function() require("dap").terminate() end,         desc = "Stop" },
			{ "<leader>dw", function() require("dap.ui.widgets").hover() end,  desc = "Value under cursor" },
		},
		opts = { setup = {} },
		config = function(_, opts)
			local dap = require("dap")
			vim.api.nvim_set_hl(0, "DapStoppedLine", { default = true, link = "Visual" })
			for name, sign in pairs(require("config.icons").dap) do
				sign = type(sign) == "table" and sign or { sign }
				vim.fn.sign_define("Dap" .. name, {
					text = sign[1],
					texthl = sign[2] or "DiagnosticInfo",
					linehl = sign[3],
					numhl = sign[3],
				})
			end
			for _, setup in pairs(opts.setup) do
				setup(dap)
			end
		end,
	},
}
