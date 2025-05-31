return {
	-- AI-powered code actions
	{
		"piersolenski/wtf.nvim",
		dependencies = {
			"MunifTanjim/nui.nvim",
		},
		opts = {
			-- Default AI popup keybindings
			popup_type = "popup", -- | "split" | "popup"
			-- An alternative way to set your API key
			openai_api_key = "echo OPENAI_API_KEY",
			-- ChatGPT Model
			openai_model_id = "gpt-3.5-turbo",
			-- Set your preferred language for the response
			language = "english",
			-- Any additional instructions
			additional_instructions = "Start the reply with 'Oh fuck, ' and keep it casual and brief.",
			-- Default search engine, can be overridden by passing an option to WtfSeatch
			search_engine = "google", -- | "duck_duck_go" | "stack_overflow" | "github"
		},
		keys = {
			{
				"gw",
				mode = { "n", "x" },
				function()
					require("wtf").ai()
				end,
				desc = "Debug with AI",
			},
			{
				mode = { "n" },
				"gW",
				function()
					require("wtf").search()
				end,
				desc = "Search diagnostic with Google",
			},
		},
	},
}
