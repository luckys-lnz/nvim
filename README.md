# 🌟 Neovim Configuration

![Neovim](https://img.shields.io/badge/Neovim-%2300B57F.svg?style=for-the-badge&logo=neovim&logoColor=white) ![Lua](https://img.shields.io/badge/Lua-%232C2D72.svg?style=for-the-badge&logo=lua&logoColor=white) ![Arch Linux](https://img.shields.io/badge/Arch_Linux-%231793D1.svg?style=for-the-badge&logo=arch-linux&logoColor=white)

🚀 **Blazing fast, minimal, and highly customizable Neovim setup.**

---

## ✨ Features

✅ **Lazy.nvim** - Fast plugin management with lazy loading
✅ **LSP & Treesitter** - Superior syntax highlighting & IntelliSense
✅ **Auto-completion** - Powered by `nvim-cmp`
✅ **Telescope** - Fuzzy finding at the speed of thought
✅ **Neotree** - Elegant file explorer
✅ **DAP** - Debugging support for multiple languages
✅ **Git Integration** - Interactive Git UI inside Neovim
✅ **Custom Keybindings** - Optimized for speed & efficiency

---

## 📂 Installation

### **Prerequisites**
- Neovim (v0.9+)
- [Ripgrep](https://github.com/BurntSushi/ripgrep) (for Telescope fuzzy search)
- [Nerd Fonts](https://www.nerdfonts.com/) (for better icon rendering)
- [Node.js](https://nodejs.org/) (for LSP & Debugging tools)
- [Python](https://www.python.org/) (for some plugins like `debugpy`)

### **Setup**
```sh
# Clone this repository
git clone https://github.com/luckys-lnz/my_vimrc_config.git ~/.config/nvim

# Install plugins
nvim +Lazy sync +qall

# Open Neovim
nvim
```

---

## ⚡ Keybindings

| Keybinding     | Action                   |
|---------------|--------------------------|
| `<leader>ff`  | Find files with Telescope |
| `<leader>fg`  | Grep text in project      |
| `<leader>fb`  | List open buffers         |
| `<leader>e`   | Toggle file explorer      |
| `<leader>gg`  | Open lazygit              |
| `<leader>gd`  | Git diff view             |
| `<leader>rn`  | Rename symbol             |
| `<leader>ca`  | Code actions              |
| `<leader>lf`  | Format code               |
| `<leader>db`  | Debug breakpoint toggle   |

_For the full list of keybindings, check out the `lua/keybindings.lua` file._

---

## 🛠 Plugins

| Plugin | Description |
|--------|------------|
| [Lazy.nvim](https://github.com/folke/lazy.nvim) | Plugin manager |
| [nvim-lspconfig](https://github.com/neovim/nvim-lspconfig) | Language server protocol (LSP) support |
| [telescope.nvim](https://github.com/nvim-telescope/telescope.nvim) | Fuzzy finder |
| [nvim-cmp](https://github.com/hrsh7th/nvim-cmp) | Autocompletion engine |
| [neotree](https://github.com/nvim-neo-tree/neo-tree.nvim) | File explorer |
| [DAP](https://github.com/mfussenegger/nvim-dap) | Debugging support |
| [treesitter](https://github.com/nvim-treesitter/nvim-treesitter) | Better syntax highlighting |
| [lualine.nvim](https://github.com/nvim-lualine/lualine.nvim) | Statusline |
| [gitsigns.nvim](https://github.com/lewis6991/gitsigns.nvim) | Git integration |

---

## 🎨 Customization

### **Theme & Appearance**
- **Theme:** `tokyonight` (changeable in `lua/plugins/colorscheme.lua`)
- **Transparent Background:** Enabled (can be disabled in `autocmds.lua`)
- **Icons:** `nvim-web-devicons` for a better UI

```lua
require("tokyonight").setup({
  style = "night",
  transparent = true,
})
```

---

## 🛑 Troubleshooting

💡 **Common Issues & Fixes**

1. **Neovim not launching properly?**
   ```sh
   nvim --headless +Lazy sync +qall
   ```
2. **LSP not working?**
   ```sh
   :LspInfo  # Check LSP status
   :Mason    # Install missing LSPs
   ```
3. **Icons not showing?**
   - Install a [Nerd Font](https://www.nerdfonts.com/) and set it in your terminal

---

## 🎯 Roadmap

🔹 Improve startup performance 🚀
🔹 Add more debugging integrations 🔍
🔹 Enhance UI elements 🎨
🔹 Introduce better workspace automation ⚙️

---

## ❤️ Credits

- [Neovim](https://neovim.io/)
- [Lazy.nvim](https://github.com/folke/lazy.nvim)
- [tokyonight.nvim](https://github.com/folke/tokyonight.nvim)
- All the amazing plugin developers! 🙌

🚀 **Enjoy coding with Neovim!**


