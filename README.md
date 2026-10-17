# Neovim for VS Code people

A focused Neovim 0.12 setup for **Python**, **C**, and **TypeScript / JavaScript / React / Next.js**.
It aims to feel familiar on day one (VS Code shortcuts work) and to teach you the Vim way as you go.

> **Lost? Press `Space` and wait** — every key is listed.
> **Know the VS Code shortcut but not the Vim one? Press `Space ?`**, type it (`ctrl+shift+f`, `rename`, `debug`…), hit Enter to run it.

---

## Install

```sh
# 1. System tools (Ubuntu/Debian shown)
sudo apt install ripgrep fd-find git curl unzip build-essential gdb nodejs npm python3-venv
#    lazygit (optional, for Space gg): https://github.com/jesseduffield/lazygit#installation
#    A Nerd Font in your terminal: https://www.nerdfonts.com  (e.g. JetBrainsMono Nerd Font)

# 2. Start Neovim — plugins, language servers, formatters, debuggers and
#    treesitter parsers install themselves on first launch (a few minutes).
#    If a download fails (flaky network), just quit and start again: installs resume,
#    and syntax highlighting switches on by itself once the parsers are compiled.
nvim

# 3. One-time logins
:Copilot auth          # GitHub Copilot
```

Check everything is healthy any time:

```sh
nvim --headless -c "luafile ~/.config/nvim/scripts/check.lua"                    # config + keymaps
nvim --headless -c "luafile ~/.config/nvim/scripts/check.lua" src/app/page.tsx   # + LSP/treesitter for a file
```

Inside Neovim: `:checkhealth`, `:Lazy` (plugins), `:Mason` (tools), `:ConformInfo` (formatters).

---

## What you get per language

| | Python | C | TypeScript / React / Next.js |
|---|---|---|---|
| IntelliSense | basedpyright | clangd (+ clang-tidy) | vtsls (VS Code's TS engine), emmet, tailwindcss |
| Lint | ruff | clang-tidy | eslint (project's own config) |
| Format on save | ruff (+ import sort) | clang-format | prettier / prettierd, eslint fix-all |
| Debug (F5) | debugpy | codelldb, gdb | js-debug: Node, Next.js server, Chrome |
| Tests | pytest | — | jest, vitest |
| Extras | venv picker `Space cv` | header⇄source `Space ch` | add/remove imports, package.json scripts `Space rs` |

Plus: HTML, CSS/SCSS, JSON & YAML with schemas (package.json, tsconfig, GitHub Actions…), Lua (for this config).

**C projects** need `compile_commands.json` (CMake: `-DCMAKE_EXPORT_COMPILE_COMMANDS=ON`; Make: `bear -- make`)
or a `compile_flags.txt` so clangd knows your include paths.

**Debugging:** an existing `.vscode/launch.json` in your project is picked up automatically.

---

## The 20 keys to learn first

| You want to… | VS Code | Here |
|---|---|---|
| Open a file | Ctrl+P | `Ctrl+P` or `Space Space` |
| Search the project | Ctrl+Shift+F | `Space /` |
| Command palette | Ctrl+Shift+P | `Space sc` |
| File explorer | Ctrl+Shift+E | `Space e` |
| Save | Ctrl+S | `Ctrl+S` (Vim: `:w`) |
| Comment | Ctrl+/ | `Ctrl+/` (Vim: `gcc`) |
| Go to definition / back | F12 / Alt+← | `gd` / `Ctrl+O` |
| References | Shift+F12 | `grr` |
| Rename | F2 | `F2` |
| Quick fix | Ctrl+. | `Space ca` |
| Problems panel | Ctrl+Shift+M | `Space xx` |
| Next problem | F8 | `]d` |
| Terminal | <kbd>Ctrl+`</kbd> | `Ctrl+\` |
| Switch tabs | Ctrl+Tab | `Shift+H` / `Shift+L` |
| Close tab | Ctrl+W | `Space bd` |
| Multi-cursor | Ctrl+D | `Alt+N` |
| Debug | F5 / F9 / F10 / F11 | same |
| Run tests | — | `Space tt` |
| Git | Ctrl+Shift+G | `Space gg` (lazygit) or `Space gs` |
| Copilot Chat | Ctrl+Alt+I | `Space aa` |

Full list: **[CHEATSHEET.md](CHEATSHEET.md)** (generated) or `Space ?` in the editor.

### A learning path

1. **Week 1 — survive.** Use the VS Code-style keys above. Glance at the tip in the statusline now and then.
2. **Week 2 — verbs + objects.** `ciw` change word, `di(` delete inside parens, `daf` delete function, `.` repeat.
3. **Week 3 — move like a local.** `s` + 2 letters (Flash), `f`/`t`, `]f` next function, `%`, `Ctrl+O`.
4. **Week 4 — training mode.** `Space uH` turns on Hardtime, which nudges you off arrow-key / `jjjj` habits.

---

## Coming from the previous version of this config

Most keys stayed. These moved — the new home is listed so muscle memory can catch up:

| Old | New | Why |
|---|---|---|
| `Space /` clear highlight | `Esc` | `Space /` is now **project search** (VS Code Ctrl+Shift+F) |
| `Space qq` = `:q` | `Space qq` = quit **all** · `:q` closes one window | one key to leave Neovim |
| `Alt+←↑↓→` resize windows | `Ctrl+←↑↓→` | `Alt+↑/↓` now **move lines**, like VS Code |
| `Space T…` tests | `Space t…` (`tt` nearest, `tf` file, `td` debug) | tests are the more common action |
| `Space tt/tf/th/tv` terminal | `Ctrl+\` (or <kbd>Ctrl+`</kbd>) · `Space ft` float | |
| `Space ui` inlay hints | `Space uh` | all toggles live under `Space u` |
| `Space tb` line blame | `Space ub` | ditto |
| `Space bc` close buffer | `Space bd` (or `Alt+w`) | |
| `Space sp` / `sP` swap argument | `Space cs` / `cS` | `Space s` is search |
| `Space pv` venv | `Space cv` | |
| `Space wh` split | `Space ws` (or `Space -`, `Space \|`) | |
| `Space mp` markdown preview | `Space cp` (in markdown files) | |
| `]T` / `[T` Trouble items | `]q` / `[q` | |
| `Space z…`, `Space oaf`… (ufo folds) | `za` `zR` `zM` `zc` `zo` | folding is native now |
| `Space sr` SnipRun (its file was never actually loaded) | `Space rr` run file | |
| `Space tda/tdf/…` insert TODO | type `TODO:` yourself, `Space st` lists them | |
| terminal `Esc` → normal mode | `Esc Esc` | single `Esc` reaches programs inside the terminal |
| `d` deleted without yanking | `d` cuts (Vim default) · `"_d` deletes | `dd` + `p` moves a line |

Removed: Go & Rust tooling, Comment.nvim (`gc` is built in), telescope (→ snacks picker), nvim-cmp (→ blink),
alpha/notify/dressing/toggleterm/lazygit.nvim/bufdelete/indent-blankline/mini.* (→ snacks), barbecue (→ dropbar),
nvim-ufo, nvim-scrollbar, eslint.nvim, nvim-lint (ruff & eslint run as language servers).

---

## Layout

```
init.lua                 leader key, then loads everything below
lua/config/              options · keymaps · autocmds · lazy.nvim bootstrap · icons
lua/plugins/ui/          theme, statusline, tabs, dashboard/picker (snacks), noice, which-key
lua/plugins/editor/      explorer, git, treesitter, motions, Trouble, sessions
lua/plugins/coding/      completion, LSP core, formatting, Copilot
lua/plugins/lang/        python.lua · c.lua · web.lua · lua.lua   ← one file per language
lua/plugins/tools/       debugger, test runner, database, markdown preview
lua/guru/                the cheatsheet (keys.lua is the data)
lua/util/                run-file / npm-script helpers
scripts/                 check.lua (self-test) · gen-cheatsheet.lua
```

**Adding a language** = one new file in `lua/plugins/lang/` that extends the shared specs:

```lua
return {
  { "nvim-treesitter/nvim-treesitter", opts = { ensure_installed = { "go" } } },
  { "neovim/nvim-lspconfig", opts = { servers = { gopls = {} } } },
  { "stevearc/conform.nvim", opts = { formatters_by_ft = { go = { "gofmt" } } } },
  { "WhoIsSethDaniel/mason-tool-installer.nvim", opts = { ensure_installed = { "delve" } } },
}
```

**Adding a key** = map it with a `desc` (so which-key shows it) and, if it's worth learning, add a line to
`lua/guru/keys.lua`, then run `nvim -l scripts/gen-cheatsheet.lua`. `scripts/check.lua` fails if a
cheatsheet entry points at a key that isn't mapped.

---

## Terminal notes

Some chords only reach Neovim if your terminal supports the kitty/CSI-u keyboard protocol
(kitty, WezTerm, Ghostty, foot, recent Alacritty/iTerm2): `Ctrl+Shift+P`, `Ctrl+.`, <kbd>Ctrl+`</kbd>.
Every one of them has a `Space` alternative. To see what your terminal sends for a key:
enter insert mode, press `Ctrl+V`, then the key.
