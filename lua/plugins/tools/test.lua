-- Test runner (VS Code Testing panel): pytest · jest · vitest.
-- ✓/✗ appear next to each test. Language files add adapters via opts.adapters.

return {
	{
		"nvim-neotest/neotest",
		dependencies = { "nvim-neotest/nvim-nio", "nvim-lua/plenary.nvim", "nvim-treesitter/nvim-treesitter" },
		-- stylua: ignore
		keys = {
			{ "<leader>tt", function() require("neotest").run.run() end,                      desc = "Run nearest test" },
			{ "<leader>tf", function() require("neotest").run.run(vim.fn.expand("%")) end,    desc = "Run tests in file" },
			{ "<leader>tA", function() require("neotest").run.run(vim.uv.cwd()) end,          desc = "Run all tests" },
			{ "<leader>tl", function() require("neotest").run.run_last() end,                 desc = "Re-run last" },
			{ "<leader>td", function() require("neotest").run.run({ strategy = "dap" }) end,  desc = "Debug nearest test" },
			{ "<leader>ts", function() require("neotest").summary.toggle() end,               desc = "Test explorer (toggle)" },
			{ "<leader>to", function() require("neotest").output.open({ enter = true, auto_close = true }) end, desc = "Show output" },
			{ "<leader>tO", function() require("neotest").output_panel.toggle() end,          desc = "Output panel (toggle)" },
			{ "<leader>tS", function() require("neotest").run.stop() end,                     desc = "Stop" },
			{ "<leader>tw", function() require("neotest").watch.toggle(vim.fn.expand("%")) end, desc = "Watch file (toggle)" },
		},
		opts = {
			adapters = {},
			status = { virtual_text = true },
			output = { open_on_run = true },
			quickfix = { open = false },
		},
		config = function(_, opts)
			-- Turn { ["neotest-python"] = { …config } } into adapter instances
			local adapters = {}
			for name, config in pairs(opts.adapters or {}) do
				local ok, adapter = pcall(require, name)
				if ok then
					if type(config) == "table" and next(config) then
						local meta = getmetatable(adapter)
						if adapter.setup then
							adapter.setup(config)
						elseif adapter.adapter then
							adapter.adapter(config)
							adapter = adapter.adapter
						elseif meta and meta.__call then
							adapter = adapter(config)
						end
					end
					adapters[#adapters + 1] = adapter
				else
					vim.notify("neotest adapter not found: " .. name, vim.log.levels.WARN)
				end
			end
			opts.adapters = adapters
			require("neotest").setup(opts)
		end,
	},
}
