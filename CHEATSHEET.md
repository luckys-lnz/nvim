# Cheatsheet — VS Code → Neovim

> Generated from `lua/guru/keys.lua` by `nvim -l scripts/gen-cheatsheet.lua`.
> Inside Neovim press **`Space ?`** for the searchable, runnable version.

`Space` is the leader key. `<C-x>` = Ctrl+x, `<A-x>`/`<M-x>` = Alt+x, `<S-x>` = Shift+x.


## Files

| VS Code | Neovim | Does |
|---|---|---|
| Ctrl+P | `<C-p>` | Quick-open a file |
| Ctrl+P | `Space Space` | Smart open: buffers + recent + files |
| Ctrl+R | `Space fr` | Recent files |
| Ctrl+Tab | `Space ,` | Switch between open buffers |
| Ctrl+Shift+E | `Space e` | Toggle file explorer<br><sub>In the tree: a add · d delete · r rename · c copy · m move · ? help</sub> |
| Reveal in Explorer | `Space E` | Reveal current file in explorer |
| Ctrl+S | `<C-s>` | Save file<br><sub>The Vim way is :w&lt;Enter>. :wa saves all, :x saves & closes.</sub> |
| Ctrl+N | `Space bn` | New empty buffer |
|  | `Space fc` | Open a file from this config |
| Rename file | `Space cR` | Rename file and update imports |

## Tabs

| VS Code | Neovim | Does |
|---|---|---|
| Ctrl+PgUp/PgDn | `<S-h>` | Previous tab (buffer) |
| Ctrl+PgDn | `<S-l>` | Next tab (buffer) |
| Alt+1-9 | `<A-1>` | Go to tab 1-9 (Alt+number) |
| Ctrl+W | `Space bd` | Close tab (buffer)<br><sub>Alt+w also closes. &lt;Space>bo closes all others.</sub> |
| Close Others | `Space bo` | Close all other tabs |
| Pin tab | `Space bp` | Pin tab |
|  | `Space `` | Jump to the previous buffer (toggle) |

## Windows

| VS Code | Neovim | Does |
|---|---|---|
| Ctrl+\ | `Space \|` | Split editor right |
|  | `Space -` | Split editor down |
| Ctrl+1/2/3 | `<C-h>` | Focus window left (C-j/k/l for others) |
|  | `Space wc` | Close window |
| Maximize group | `Space wm` | Zoom window (toggle) |
|  | `<C-Left>` | Resize window (Ctrl+arrows) |

## Search

| VS Code | Neovim | Does |
|---|---|---|
| Ctrl+Shift+F | `Space /` | Search text in project |
|  | `Space sw` | Search word under cursor in project |
| Ctrl+F | `/` | Find in file (n / N = next / prev) |
| Ctrl+H | `:%s/old/new/g` | Replace in file (add c at end to confirm each) |
|  | `*` | Search word under cursor in file |
| Ctrl+Shift+P | `<C-S-p>` | Command palette<br><sub>If your terminal can't send Ctrl+Shift+P use &lt;Space>sc.</sub> |
| Ctrl+Shift+P | `Space sc` | Command palette |
| Ctrl+K Ctrl+S | `Space sk` | Search ALL keymaps |
|  | `Space sh` | Search help pages |
|  | `Space sr` | Resume last search |
| Ctrl+Shift+O | `Space ss` | Go to symbol in file |
| Ctrl+T | `Space sS` | Go to symbol in workspace |
| Timeline | `Space su` | Undo history (time travel) |

## Edit

| VS Code | Neovim | Does |
|---|---|---|
| Ctrl+/ | `<C-/>` | Toggle comment<br><sub>Vim way: gcc (line) · gc{motion} e.g. gcip = comment paragraph</sub> |
| Ctrl+/ | `gcc` | Comment line (gc + motion for more) |
| Alt+↑/↓ | `<A-j>` | Move line down (Alt+k up, or Alt+arrows) |
| Shift+Alt+↓ | `yyp` | Duplicate line |
| Ctrl+Shift+K | `dd` | Delete (cut) line |
| Ctrl+X / Ctrl+C | `dd / yy` | Cut / copy line — p pastes below |
| Ctrl+Z / Ctrl+Y | `u / <C-r>` | Undo / redo |
| Ctrl+A | `<C-a>` | Select all |
| Ctrl+] | `>>` | Indent line (&lt;&lt; outdent; > / &lt; in visual) |
| Ctrl+D | `<M-n>` | Multi-cursor: add next match<br><sub>Then type to edit all. &lt;M-x> skip · &lt;M-p> remove · Esc exit</sub> |
| Ctrl+Shift+L | `<M-a>` | Multi-cursor: select all matches |
| Ctrl+Alt+↓ | `<C-M-j>` | Multi-cursor: add cursor below |
| Expand selection | `<C-Space>` | Expand selection by syntax (BS shrinks) |
|  | `ysiw"` | Surround word with quotes<br><sub>ys{motion}{char} add · ds" delete · cs"' change " to '</sub> |
|  | `Space cs` | Swap function argument with next |

## Code

| VS Code | Neovim | Does |
|---|---|---|
| F12 | `gd` | Go to definition<br><sub>Ctrl+o jumps back, Ctrl+i forward — like Alt+← / Alt+→</sub> |
| Alt+F12 | `gpd` | Peek definition |
| Shift+F12 | `grr` | Find all references |
| Ctrl+F12 | `gri` | Go to implementation |
|  | `grt` | Go to type definition |
| Hover | `K` | Hover docs (press K again to enter) |
| Ctrl+Shift+Space | `gK` | Signature help (Ctrl+k in insert) |
| F2 | `<F2>` | Rename symbol (live preview)<br><sub>Built-in alternative: grn</sub> |
| Ctrl+. | `Space ca` | Code action / quick fix<br><sub>Also gra (built-in) or Ctrl+. if your terminal sends it</sub> |
| Organize Imports | `Space co` | Organize imports |
| Shift+Alt+F | `Space cf` | Format file (also runs on save) |
| Ctrl+Space | `<C-Space>` _(insert)_ | Trigger completion (insert mode) |
| Tab | `<Tab>` _(insert)_ | Accept completion / Copilot suggestion |
| Breadcrumbs | `Space ;` | Pick a symbol from the breadcrumbs |
| Outline | `Space xs` | Symbol outline panel |
|  | `Space uh` | Toggle inlay type hints |

## Problems

| VS Code | Neovim | Does |
|---|---|---|
| Ctrl+Shift+M | `Space xx` | Problems panel (workspace) |
|  | `Space xX` | Problems in this file |
| F8 | `]d` | Next problem ([d prev, ]e errors only) |
|  | `Space cd` | Show the problem on this line |
|  | `]t` | Next TODO/FIX comment |

## Python

| VS Code | Neovim | Does |
|---|---|---|
| Select Interpreter | `Space cv` | Select virtualenv |
| Run Python File | `Space rr` | Run current file in a terminal |

## C

| VS Code | Neovim | Does |
|---|---|---|
| Alt+O | `Space ch` | Switch header ⇄ source |
| Run Code | `Space rr` | Compile with cc -Wall and run |

## Web

| VS Code | Neovim | Does |
|---|---|---|
| npm scripts | `Space rs` | Run a package.json script (dev, build…) |
| Add missing imports | `Space cM` | Add all missing imports (TS) |
|  | `Space cu` | Remove unused imports (TS) |
| Emmet | `div.card>p*3` | Type an Emmet abbreviation, pick it from completion |

## Debug

| VS Code | Neovim | Does |
|---|---|---|
| F5 | `<F5>` | Start / continue debugging |
| F9 | `<F9>` | Toggle breakpoint |
| F10 | `<F10>` | Step over |
| F11 | `<F11>` | Step into (Shift+F11 out) |
| Shift+F5 | `Space dt` | Stop debugging |
|  | `Space dB` | Conditional breakpoint |
|  | `Space du` | Debugger UI (toggle) |
| Debug Console | `Space dr` | Debug REPL |

## Test

| VS Code | Neovim | Does |
|---|---|---|
| Run Test | `Space tt` | Run nearest test |
|  | `Space tf` | Run tests in this file |
| Debug Test | `Space td` | Debug nearest test |
| Testing panel | `Space ts` | Test explorer |

## Git

| VS Code | Neovim | Does |
|---|---|---|
| Ctrl+Shift+G | `Space gg` | Lazygit (full git UI)<br><sub>Needs the lazygit binary. &lt;Space>gs is a built-in alternative.</sub> |
| Source Control | `Space gs` | Changed files |
|  | `]h` | Next change in file ([h prev) |
| Stage Change | `Space hs` | Stage hunk under cursor |
| Revert Change | `Space hr` | Discard hunk under cursor |
|  | `Space hp` | Preview hunk inline |
| GitLens blame | `Space ub` | Toggle inline blame |
| Open Changes | `Space gd` | Diff view of working tree |
| Timeline | `Space gh` | File history |

## Terminal

| VS Code | Neovim | Does |
|---|---|---|
| Ctrl+` | `<C-\>` | Toggle terminal (Ctrl+` too)<br><sub>Esc Esc leaves terminal mode so you can scroll/copy</sub> |

## AI

| VS Code | Neovim | Does |
|---|---|---|
| Ctrl+Alt+I | `Space aa` | Copilot Chat (toggle) — also F8 |
| /explain | `Space ae` _(visual)_ | Explain selected code |
| /fix | `Space af` _(visual)_ | Fix selected code |
| Accept suggestion | `<M-l>` _(insert)_ | Accept Copilot ghost text (or Tab) |

## UI

| VS Code | Neovim | Does |
|---|---|---|
| Zen Mode | `Space uz` | Zen mode |
| Color Theme | `Space uT` | Toggle dark / light theme |
| Word Wrap (Alt+Z) | `Space uw` | Toggle word wrap |
|  | `Space uf` | Toggle format on save |
|  | `Space uH` | Hardtime: motion-training mode |

## Session

| VS Code | Neovim | Does |
|---|---|---|
| Reopen folder | `Space qs` | Restore session for this folder |
| Quit | `Space qq` | Quit all (asks to save) |

## Vim

| VS Code | Neovim | Does |
|---|---|---|
|  | `ciw` | Change inner word (diw delete, yiw copy)<br><sub>verb + object: c/d/y + iw/i"/i(/ip/af/ic … works everywhere</sub> |
|  | `ci"` | Change text inside quotes (works for ( [ { ' ` too) |
|  | `daf` | Delete a whole function (treesitter object)<br><sub>af/if function · ac/ic class · aa/ia argument · ai/ii if · al/il loop</sub> |
|  | `.` | Repeat the last change |
|  | `s` | Flash: jump anywhere with 2 chars + label |
|  | `f{char}` | Jump to next {char} on line (; repeats, t stops before) |
|  | `%` | Jump to matching bracket |
|  | `]f` | Next function ([f prev, ]o class, ]a argument) |
|  | `<C-o>` | Jump back (Ctrl+i forward) |
|  | `qa … q` | Record macro into a, @a plays it, @@ repeats |
|  | `zz` | Centre the screen on the cursor (zt top, zb bottom) |
|  | `za` | Toggle fold (zR open all, zM close all) |
|  | `gv` | Reselect last selection |
|  | `<C-v>` | Block (column) selection — I or A to insert on every line |
|  | `Space ?` | Open this cheatsheet |
