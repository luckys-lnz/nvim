return {
	-- VS Code-like Notifications with nvim-notify
	{
		"rcarriga/nvim-notify",
		-- Keybindings for dismissing notifications
		keys = {
			{
				"<leader>un", -- Trigger keybinding for dismissing all notifications
				function()
					require("notify").dismiss({ silent = true, pending = true })
				end,
				desc = "Dismiss all notifications", -- Description for clarity
			},
		},

		-- Options for customizing notification behavior
		opts = {
			timeout = 3000, -- Time in milliseconds before notifications fade out
			max_height = function()
				return math.floor(vim.o.lines * 0.75) -- Set max height to 75% of the terminal height
			end,
			max_width = function()
				return math.floor(vim.o.columns * 0.75) -- Set max width to 75% of the terminal width
			end,
			on_open = function(win)
				-- Set a high zindex so the notification appears on top of other windows
				vim.api.nvim_win_set_config(win, { zindex = 100 })
			end,
			background_colour = "#282828", -- Custom background color (dark gray, replace with your choice)
			render = "wrapped-compact", -- Render notifications in a compact, wrapped format
		},

		-- Initialization for fallback when Noice is not available
		init = function()
			-- Use 'notify' for notifications in Neovim
			vim.notify = require("notify")
		end,

		-- Custom notifications for different levels (info, warn, error, etc.)
		custom_notify = function(message, level)
			-- Customize the look and feel of specific levels of notifications
			local level_map = {
				info = { icon = "ℹ️", bg = "#4caf50", fg = "#ffffff" },
				warn = { icon = "⚠️", bg = "#ffeb3b", fg = "#000000" },
				error = { icon = "❌", bg = "#f44336", fg = "#ffffff" },
			}
			local icon = level_map[level] and level_map[level].icon or "🔔"
			local bg = level_map[level] and level_map[level].bg or "#000000"
			local fg = level_map[level] and level_map[level].fg or "#ffffff"

			-- Display the notification with the appropriate icon and color scheme
			require("notify")(icon .. " " .. message, level, {
				background_colour = bg,
				icon = icon,
				timeout = 5000, -- Adjust timeout per notification type
				render = "default",
				background = true,
			})
		end,
	},
}
