-- lua/plugins/lsp/keymaps.lua
-- LSP keymaps for a VS Code-like experience

local M = {}

function M.on_attach(client, buffer)
	local self = M.new(client, buffer)

	-- Navigation
	self:map("gd", function()
		vim.lsp.buf.definition()
	end, { desc = "Goto Definition" })
	self:map("gr", function()
		vim.lsp.buf.references()
	end, { desc = "References" })
	self:map("gD", function()
		vim.lsp.buf.declaration()
	end, { desc = "Goto Declaration" })
	self:map("gI", function()
		vim.lsp.buf.implementation()
	end, { desc = "Goto Implementation" })
	self:map("gt", function()
		vim.lsp.buf.type_definition()
	end, { desc = "Goto Type Definition" })
	
	-- Documentation
	self:map("K", function()
		vim.lsp.buf.hover()
	end, { desc = "Hover" })
	self:map("gK", function()
		vim.lsp.buf.signature_help()
	end, { desc = "Signature Help" })
	self:map("<C-k>", function()
		vim.lsp.buf.signature_help()
	end, { mode = "i", desc = "Signature Help" })
	
	-- Code Actions
	self:map("<leader>ca", function()
		vim.lsp.buf.code_action()
	end, { desc = "Code Action", mode = { "n", "v" } })
	self:map("<leader>cr", function()
		vim.lsp.buf.rename()
	end, { desc = "Rename" })
	-- Using F2 for rename is already defined in the main keymaps file
	
	-- Diagnostics
	self:map("<leader>cd", function()
		vim.diagnostic.open_float()
	end, { desc = "Line Diagnostics" })
	self:map("]d", function()
		vim.diagnostic.goto_next()
	end, { desc = "Next Diagnostic" })
	self:map("[d", function()
		vim.diagnostic.goto_prev()
	end, { desc = "Prev Diagnostic" })
	self:map("]e", function()
		vim.diagnostic.goto_next({ severity = vim.diagnostic.severity.ERROR })
	end, { desc = "Next Error" })
	self:map("[e", function()
		vim.diagnostic.goto_prev({ severity = vim.diagnostic.severity.ERROR })
	end, { desc = "Prev Error" })
	self:map("]w", function()
		vim.diagnostic.goto_next({ severity = vim.diagnostic.severity.WARN })
	end, { desc = "Next Warning" })
	self:map("[w", function()
		vim.diagnostic.goto_prev({ severity = vim.diagnostic.severity.WARN })
	end, { desc = "Prev Warning" })

	-- Formatting
	self:map("<leader>cf", function()
		vim.lsp.buf.format({ async = true })
	end, { desc = "Format Document" })
	self:map("<leader>cf", function()
		vim.lsp.buf.range_formatting()
	end, { desc = "Format Range", mode = "v" })

	-- Workspace
	self:map("<leader>wa", function()
		vim.lsp.buf.add_workspace_folder()
	end, { desc = "Add Folder" })
	self:map("<leader>wr", function()
		vim.lsp.buf.remove_workspace_folder()
	end, { desc = "Remove Folder" })
	self:map("<leader>wl", function()
		print(vim.inspect(vim.lsp.buf.list_workspace_folders()))
	end, { desc = "List Folders" })
end

function M.new(client, buffer)
	return setmetatable({ client = client, buffer = buffer }, { __index = M })
end

function M:has(cap)
	return self.client.server_capabilities[cap .. "Provider"]
end

function M:map(lhs, rhs, opts)
	opts = opts or {}
	if opts.has and not self:has(opts.has) then
		return
	end
	vim.keymap.set(
		opts.mode or "n",
		lhs,
		type(rhs) == "string" and ("<cmd>%s<cr>"):format(rhs) or rhs,
		---@diagnostic disable-next-line: no-unknown
		{ silent = true, buffer = self.buffer, expr = opts.expr, desc = opts.desc }
	)
end

return M
