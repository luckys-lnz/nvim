-- Guru: learn Neovim by searching for what you already know from VS Code.
--
--   <Space>?   open the cheatsheet picker
--              type "ctrl+p", "rename", "debug", "<leader>g" … anything
--              <Enter> runs the action, so you learn by doing
--   :Guru      same thing

local M = {}

math.randomseed(vim.uv.hrtime()) -- LuaJIT starts with the same seed every launch

local function entries() return require("guru.keys").list end

local function pretty(keys) return (keys:gsub("<leader>", "Space "):gsub("<space>", "Space")) end

---"<C-S-p>" → "Ctrl+Shift+p", "<M-n>" → "Alt+n" (for people who think in VS Code)
local function human(keys)
	return (
		pretty(keys)
			:gsub("<C%-S%-(.-)>", "Ctrl+Shift+%1")
			:gsub("<C%-M%-(.-)>", "Ctrl+Alt+%1")
			:gsub("<A%-S%-(.-)>", "Alt+Shift+%1")
			:gsub("<S%-A%-(.-)>", "Alt+Shift+%1")
			:gsub("<C%-(.-)>", "Ctrl+%1")
			:gsub("<[MA]%-(.-)>", "Alt+%1")
			:gsub("<S%-(.-)>", "Shift+%1")
			:gsub("<(F%d+)>", "%1")
			:gsub("<BS>", "Backspace")
	)
end

---Pad by display width (string.format pads by bytes, which breaks on → · ↓)
local function pad(str, width) return str .. (" "):rep(math.max(1, width - vim.fn.strdisplaywidth(str))) end

---A tip string, for the statusline and dashboard.
---@param seed? integer pick deterministically (e.g. from the clock); random when nil
function M.tip(seed)
	local list = vim.tbl_filter(function(e) return e.vscode ~= "" or e.cat == "Vim" end, entries())
	local e = list[(seed or math.random(1, 1e6)) % #list + 1]
	local from = e.vscode ~= "" and (e.vscode .. " → ") or ""
	return ("%s%s  %s"):format(from, pretty(e.keys), e.desc)
end

---Can we run this entry by feeding its keys?  (Only real normal-mode mappings.)
local function runnable(e) return (e.mode or "n") == "n" and e.kind ~= "builtin" and not e.keys:find(" ") end

function M.open()
	local items = {}
	for i, e in ipairs(entries()) do
		items[#items + 1] = {
			idx = i,
			entry = e,
			-- everything here is searchable
			text = table.concat({ e.cat, e.vscode, e.keys, pretty(e.keys), e.desc, e.tip or "" }, " "),
			preview = {
				text = table.concat({
					"  " .. e.desc,
					"",
					"  Neovim     "
						.. pretty(e.keys)
						.. (human(e.keys) ~= pretty(e.keys) and ("   (" .. human(e.keys) .. ")") or ""),
					"  VS Code    " .. (e.vscode ~= "" and e.vscode or "—"),
					"  Mode       " .. ({ n = "normal", i = "insert", x = "visual" })[e.mode or "n"],
					"",
					e.tip and ("  Tip: " .. e.tip) or "",
					"",
					runnable(e) and "  ⏎ Enter runs it now — learn by doing."
						or "  Try it yourself in a buffer (needs a motion, a selection or insert mode).",
				}, "\n"),
			},
		}
	end

	Snacks.picker({
		title = "Guru · VS Code → Neovim",
		items = items,
		layout = { preset = "vertical", layout = { width = 0.75 } },
		preview = "preview",
		win = { preview = { minimal = true } },
		format = function(item)
			local e = item.entry
			return {
				{ pad(e.cat, 9), "SnacksPickerComment" },
				{ pad(e.vscode ~= "" and e.vscode or "·", 20), "SnacksPickerLabel" },
				{ pad(pretty(e.keys), 18), "SnacksPickerSpecial" },
				{ e.desc },
			}
		end,
		confirm = function(picker, item)
			picker:close()
			if not item then return end
			local e = item.entry
			if runnable(e) then
				vim.schedule(function()
					vim.api.nvim_feedkeys(vim.keycode(e.keys), "m", false) -- <leader> is expanded by keycode()
				end)
			else
				vim.notify(("%s  →  %s"):format(pretty(e.keys), e.desc), vim.log.levels.INFO, { title = "Guru" })
			end
		end,
	})
end

vim.api.nvim_create_user_command("Guru", M.open, { desc = "VS Code → Neovim cheatsheet" })

return M
