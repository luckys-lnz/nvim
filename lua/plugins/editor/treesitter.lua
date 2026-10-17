-- Treesitter: syntax-aware highlighting, indentation, folds and text objects.
-- Uses the `main` branch API (Neovim 0.12+). Parsers compile with the
-- tree-sitter CLI, which Mason installs for us (see coding/lsp.lua).
--
-- Language files add parsers with:
--   { "nvim-treesitter/nvim-treesitter", opts = { ensure_installed = { "rust" } } }

return {
	{
		"nvim-treesitter/nvim-treesitter",
		branch = "main",
		lazy = false, -- the plugin itself is tiny; highlighting must be ready on first file
		build = ":TSUpdate",
		dependencies = { "mason-org/mason.nvim" }, -- puts tree-sitter CLI on $PATH
		opts = {
			ensure_installed = {
				"bash",
				"diff",
				"gitcommit",
				"git_rebase",
				"gitignore",
				"json",
				"lua",
				"luadoc",
				"markdown",
				"markdown_inline",
				"query",
				"regex",
				"toml",
				"vim",
				"vimdoc",
				"yaml",
			},
		},
		opts_extend = { "ensure_installed" },
		config = function(_, opts)
			local ts = require("nvim-treesitter")
			ts.setup()

			-- Turn treesitter on for a buffer if a parser for its language exists.
			local function start(buf)
				local lang = vim.treesitter.language.get_lang(vim.bo[buf].filetype)
				if not lang or not pcall(vim.treesitter.start, buf, lang) then return end
				if vim.treesitter.query.get(lang, "indents") then
					vim.bo[buf].indentexpr = "v:lua.require'nvim-treesitter'.indentexpr()"
				end
			end
			vim.api.nvim_create_autocmd("FileType", {
				group = vim.api.nvim_create_augroup("user_treesitter", { clear = true }),
				callback = function(ev) start(ev.buf) end,
			})

			-- Compile missing parsers. On a fresh machine the tree-sitter CLI is still
			-- being installed by Mason, so retry once that finishes.
			local function install_missing()
				local installed = ts.get_installed()
				local missing = {}
				for _, lang in ipairs(opts.ensure_installed) do
					if not vim.list_contains(installed, lang) and not vim.list_contains(missing, lang) then
						missing[#missing + 1] = lang
					end
				end
				if #missing == 0 then return true end
				if vim.fn.executable("tree-sitter") == 0 then return false end
				ts.install(missing, { summary = true }):await(vim.schedule_wrap(function()
					for _, buf in ipairs(vim.api.nvim_list_bufs()) do
						if vim.api.nvim_buf_is_loaded(buf) and not vim.treesitter.highlighter.active[buf] then
							start(buf)
						end
					end
				end))
				return true
			end

			if not install_missing() then
				vim.api.nvim_create_autocmd("User", {
					pattern = "MasonToolsUpdateCompleted",
					once = true,
					callback = vim.schedule_wrap(install_missing),
				})
			end
		end,
	},

	{
		"nvim-treesitter/nvim-treesitter-textobjects",
		branch = "main",
		event = "VeryLazy",
		opts = {
			select = { lookahead = true },
			move = { set_jumps = true },
		},
		config = function(_, opts)
			require("nvim-treesitter-textobjects").setup(opts)

			local select = require("nvim-treesitter-textobjects.select")
			local move = require("nvim-treesitter-textobjects.move")
			local swap = require("nvim-treesitter-textobjects.swap")
			local map = vim.keymap.set

			-- Text objects: daf = delete a function, cic = change inside class, via = select arg …
			local objects = {
				f = { "@function", "function" },
				c = { "@class", "class" },
				a = { "@parameter", "argument" },
				i = { "@conditional", "if/conditional" },
				l = { "@loop", "loop" },
			}
			for key, o in pairs(objects) do
				map(
					{ "x", "o" },
					"a" .. key,
					function() select.select_textobject(o[1] .. ".outer", "textobjects") end,
					{ desc = "a " .. o[2] }
				)
				map(
					{ "x", "o" },
					"i" .. key,
					function() select.select_textobject(o[1] .. ".inner", "textobjects") end,
					{ desc = "inner " .. o[2] }
				)
			end

			-- Motions: ]f next function start, ]F end; ]o class ("object"); ]a argument
			local moves = { f = "@function.outer", o = "@class.outer", a = "@parameter.inner" }
			local names = { f = "function", o = "class", a = "argument" }
			for key, query in pairs(moves) do
				local n = names[key]
				map(
					{ "n", "x", "o" },
					"]" .. key,
					function() move.goto_next_start(query, "textobjects") end,
					{ desc = "Next " .. n .. " start" }
				)
				map(
					{ "n", "x", "o" },
					"[" .. key,
					function() move.goto_previous_start(query, "textobjects") end,
					{ desc = "Prev " .. n .. " start" }
				)
				map(
					{ "n", "x", "o" },
					"]" .. key:upper(),
					function() move.goto_next_end(query, "textobjects") end,
					{ desc = "Next " .. n .. " end" }
				)
				map(
					{ "n", "x", "o" },
					"[" .. key:upper(),
					function() move.goto_previous_end(query, "textobjects") end,
					{ desc = "Prev " .. n .. " end" }
				)
			end

			map(
				"n",
				"<leader>cs",
				function() swap.swap_next("@parameter.inner") end,
				{ desc = "Swap argument with next" }
			)
			map(
				"n",
				"<leader>cS",
				function() swap.swap_previous("@parameter.inner") end,
				{ desc = "Swap argument with previous" }
			)
		end,
	},
}
