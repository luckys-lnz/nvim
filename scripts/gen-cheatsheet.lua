-- Regenerates CHEATSHEET.md from lua/guru/keys.lua (the same data as <Space>?).
--   nvim -l scripts/gen-cheatsheet.lua

local root = vim.fs.dirname(vim.fs.dirname(vim.fs.normalize(debug.getinfo(1, "S").source:sub(2))))
package.path = root .. "/lua/?.lua;" .. root .. "/lua/?/init.lua;" .. package.path

local list = require("guru.keys").list
local function key(k) return "`" .. k:gsub("<leader>", "Space "):gsub("<space>", "Space"):gsub("|", "\\|") .. "`" end
local function cell(s) return (s:gsub("|", "\\|"):gsub("<", "&lt;")) end

local out = {
	"# Cheatsheet — VS Code → Neovim",
	"",
	"> Generated from `lua/guru/keys.lua` by `nvim -l scripts/gen-cheatsheet.lua`.",
	"> Inside Neovim press **`Space ?`** for the searchable, runnable version.",
	"",
	"`Space` is the leader key. `<C-x>` = Ctrl+x, `<A-x>`/`<M-x>` = Alt+x, `<S-x>` = Shift+x.",
	"",
}
local cat
for _, e in ipairs(list) do
	if e.cat ~= cat then
		cat = e.cat
		vim.list_extend(out, { "", "## " .. cat, "", "| VS Code | Neovim | Does |", "|---|---|---|" })
	end
	local mode = (e.mode and e.mode ~= "n") and (" _(" .. ({ i = "insert", x = "visual" })[e.mode] .. ")_") or ""
	out[#out + 1] = ("| %s | %s%s | %s |"):format(
		e.vscode ~= "" and cell(e.vscode) or "",
		key(e.keys),
		mode,
		cell(e.desc) .. (e.tip and ("<br><sub>" .. cell(e.tip) .. "</sub>") or "")
	)
end
vim.fn.writefile(out, root .. "/CHEATSHEET.md")
print("wrote CHEATSHEET.md (" .. #list .. " entries)")
