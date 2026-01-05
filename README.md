# 🎨 My Dotfiles

A carefully crafted development environment configuration for **macOS** and **Linux**, featuring a consistent **Catppuccin Mocha** color scheme across all tools.

## ✨ Features

- 🎯 **Neovim** - Modern IDE-like setup with LSP, completion, snippets, and GitHub Copilot
- 🖥️ **Tmux** - Enhanced terminal multiplexer with vim navigation and session management
- 🐚 **Zsh** - Powerful shell with oh-my-zsh, autosuggestions, and syntax highlighting
- 🎨 **Catppuccin Theme** - Consistent Mocha colorscheme across Neovim, Tmux, and Alacritty
- 🔤 **Monaspace Nerd Font** - Beautiful coding font with ligatures and icons (included)
- ⚡ **mise** - Unified runtime version manager for Node, Python, Java, and more
- 📦 **Managed with GNU Stow** - Symlink-based dotfile management

## 📋 Prerequisites

### Common (macOS & Linux)

```bash
# Core tools
- Git
- GNU Stow
- Zsh
- Tmux
- Neovim 0.11+
- mise (version manager)
```

### macOS

```bash
# Install Homebrew if not already installed
/bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"

# Install prerequisites
brew install git stow zsh tmux neovim mise

# Install zsh plugins
brew install zsh-autosuggestions zsh-syntax-highlighting

# Install development tools via mise
mise install node@lts
mise install java@21
mise global node@lts java@21

# Install package managers
npm install -g pnpm
curl -fsSL https://bun.sh/install | bash
```

### Linux (Debian/Ubuntu)

```bash
# Update system
sudo apt update && sudo apt upgrade -y

# Install prerequisites
sudo apt install git stow zsh tmux curl build-essential -y

# Install Neovim 0.11+ (build from source or use AppImage)
# AppImage method (recommended):
curl -LO https://github.com/neovim/neovim/releases/latest/download/nvim.appimage
chmod u+x nvim.appimage
sudo mv nvim.appimage /usr/local/bin/nvim

# Install mise
curl https://mise.run | sh
echo 'eval "$(~/.local/bin/mise activate zsh)"' >> ~/.zshrc

# Install development tools via mise
mise install node@lts
mise install java@21
mise global node@lts java@21

# Install package managers
npm install -g pnpm
curl -fsSL https://bun.sh/install | bash
```

### Shell Setup (Both Platforms)

```bash
# Set Zsh as default shell
which zsh
sudo chsh -s $(which zsh)

# Install oh-my-zsh
sh -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)"

# Install zsh plugins (if not using Homebrew)
git clone https://github.com/zsh-users/zsh-autosuggestions ${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/plugins/zsh-autosuggestions
git clone https://github.com/zsh-users/zsh-syntax-highlighting.git ${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/plugins/zsh-syntax-highlighting
```

### Tmux Plugin Manager

```bash
# Install TPM (Tmux Plugin Manager)
git clone https://github.com/tmux-plugins/tpm ~/.tmux/plugins/tpm

# Install Catppuccin theme for Tmux
mkdir -p ~/.tmux/plugins/catppuccin
git clone -b v2.1.2 https://github.com/catppuccin/tmux.git ~/.tmux/plugins/catppuccin/tmux
```

## 🚀 Installation

1. **Clone the repository**

```bash
cd ~
git clone https://github.com/abdielreyes/dotfiles.git
cd dotfiles
```

2. **Install fonts** (if needed)

```bash
# macOS
cp fonts/Monaspace/*.otf ~/Library/Fonts/

# Linux
mkdir -p ~/.local/share/fonts
cp fonts/Monaspace/*.otf ~/.local/share/fonts/
fc-cache -fv
```

3. **Deploy dotfiles using Stow**

```bash
# This creates symlinks from ~/dotfiles to your home directory
stow .
```

4. **Install Tmux plugins**

```bash
# Start tmux
tmux

# Inside tmux, press: prefix + I (default prefix is Ctrl+b, then Shift+i)
# Wait for plugins to install, then exit tmux
```

5. **Install Neovim plugins**

```bash
# Open Neovim
nvim

# Lazy.nvim will automatically install all plugins on first launch
# Wait for installation to complete
```

6. **Restart your terminal**

```bash
# Restart terminal or source your shell config
exec zsh
```

## 📦 What's Included

### Neovim Configuration

- **LSP Support** - TypeScript, JavaScript, Python, Go, Rust, Java, and more
- **Completion** - nvim-cmp with LSP, snippets, path, and buffer completion
- **GitHub Copilot** - AI-powered code suggestions
- **Snippets** - LuaSnip with friendly-snippets collection
- **File Explorer** - Neo-tree and Oil.nvim for file management
- **Fuzzy Finder** - Telescope for files, grep, and more
- **Git Integration** - Fugitive and Gitsigns with blame in statusline
- **Syntax Highlighting** - Treesitter for better code highlighting
- **Formatting & Linting** - Conform.nvim and nvim-lint
- **Theme** - Catppuccin Mocha with lualine, bufferline, and which-key
- **Auto Indent Detection** - vim-sleuth with 4-space fallback

### Tmux Configuration

- **Theme** - Catppuccin Mocha
- **Vim Navigation** - Seamless pane switching with hjkl
- **Mouse Support** - Enabled
- **Plugins** - TPM, vim-tmux-navigator, tmux-resurrect, tmux-cpu
- **Custom Keybinds** - Intuitive split management

### Zsh Configuration

- **Framework** - oh-my-zsh
- **Theme** - alanpeabody
- **Plugins** - git, sudo, vi-mode
- **Enhancements** - autosuggestions, syntax highlighting
- **Aliases** - vim/vi → nvim, enhanced ls
- **Tool Integration** - mise, bun

### Alacritty Configuration

- **Theme** - Catppuccin Mocha
- **Font** - MonaspiceNe Nerd Font (size 11)
- **Cursor** - Blinking block cursor
- **Padding** - Comfortable 10px padding

## 🛠️ Customization

All configuration files are in their standard locations:

```
~/dotfiles/
├── .config/
│   ├── nvim/          # Neovim configuration
│   └── alacritty/     # Alacritty terminal config
├── .tmux.conf         # Tmux configuration
├── .zshrc             # Zsh configuration
└── fonts/             # Monaspace Nerd Font files
```

After making changes, either:
- Files are already symlinked (changes apply immediately)
- Re-run `stow .` if you added new files
- Use `stow --adopt .` to merge conflicts

## 🔧 Useful Commands

### Stow Management

```bash
# Deploy dotfiles
stow .

# Remove symlinks
stow -D .

# Adopt existing files into dotfiles
stow --adopt .

# Re-stow after changes
stow -R .
```

### Neovim

```bash
# Update plugins
:Lazy sync

# Check health
:checkhealth

# LSP info
:LspInfo

# Mason (LSP installer)
:Mason
```

### Tmux

```bash
# Reload config
prefix + r (default: Ctrl+b, then r)

# Install plugins
prefix + I

# Update plugins
prefix + U
```

## 🎨 Theme

This dotfile setup uses **Catppuccin Mocha** as the consistent theme across:
- Neovim (via catppuccin/nvim plugin)
- Tmux (via catppuccin/tmux plugin)
- Alacritty (custom color scheme)

The warm, pastel color palette provides a comfortable coding experience in both day and night settings.

## 📸 Screenshots

> Coming soon! Screenshots of the complete setup will be added here.

---

Made with ❤️ for developers who care about their environment
