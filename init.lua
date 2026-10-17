-- ┌──────────────────────────────────────────────────────────────────────────┐
-- │  Neovim — Python · C · TypeScript/JavaScript · React · Next.js           │
-- │                                                                          │
-- │  lua/config/   core editor: options, keymaps, autocmds, plugin manager   │
-- │  lua/plugins/  one folder per concern (ui, editor, coding, lang, tools)  │
-- │  lua/guru/     the VS Code → Neovim cheatsheet  (press <Space>?)         │
-- │  lua/util/     small shared helpers                                      │
-- └──────────────────────────────────────────────────────────────────────────┘

-- Leader must be set before any mapping is defined.
vim.g.mapleader = " "
vim.g.maplocalleader = "\\"

require("config.options")
require("config.lazy")

-- Keymaps and autocmds run after plugins are registered so they can use them.
require("config.keymaps")
require("config.autocmds")
