# Rutvik's Dotfiles

This repository contains my personal dotfiles for macOS development setup. These configuration files are tailored for my workflow and preferences.

## 📁 Structure

```
dotfiles/
├── .zshrc              # Main Zsh configuration with aliases, functions, and paths
├── .p10k.zsh           # Powerlevel10k prompt configuration (rainbow style)
├── .bashrc             # Bash shell configuration
├── .bash_profile       # Bash profile for login shells
├── .profile            # Universal shell profile
├── .zprofile           # Zsh profile for login shells
├── .zlogin             # Zsh login configuration
├── .tmux.conf          # Tmux terminal multiplexer configuration
├── .aerospace.toml     # AeroSpace window manager configuration
├── .gitconfig          # Git configuration
├── .default-gems       # Default Ruby gems list
├── .tool-versions      # Development tool versions
├── .npmrc              # Node Package Manager configuration
├── .yarnrc             # Yarn package manager configuration
├── config/
│   └── gh/             # GitHub CLI configuration
├── ssh/
│   └── config          # SSH client configuration
├── scripts/
│   ├── setup.sh        # Setup script to install dotfiles
│   └── sync.sh         # Script to sync changes back to repo
└── README.md           # This file
```

## 🚀 Setup

### Automatic Installation

```bash
# Clone the repository
git clone https://github.com/rutvik11062000/dotfiles.git ~/dotfiles

# Run the setup script
cd ~/dotfiles
chmod +x scripts/setup.sh
./scripts/setup.sh
```

### Manual Installation

```bash
# Clone the repository
git clone https://github.com/rutvik11062000/dotfiles.git ~/dotfiles

# Create symbolic links
ln -sf ~/dotfiles/.zshrc ~/.zshrc
ln -sf ~/dotfiles/.p10k.zsh ~/.p10k.zsh
ln -sf ~/dotfiles/.tmux.conf ~/.tmux.conf
ln -sf ~/dotfiles/.aerospace.toml ~/.aerospace.toml
ln -sf ~/dotfiles/.gitconfig ~/.gitconfig
ln -sf ~/dotfiles/.config/gh ~/.config/gh
ln -sf ~/dotfiles/ssh/config ~/.ssh/config

# Copy files that shouldn't be linked
cp ~/dotfiles/.bashrc ~/.bashrc
cp ~/dotfiles/.bash_profile ~/.bash_profile
cp ~/dotfiles/.profile ~/.profile
cp ~/dotfiles/.zprofile ~/.zprofile
cp ~/dotfiles/.default-gems ~/.default-gems
cp ~/dotfiles/.tool-versions ~/.tool-versions
cp ~/dotfiles/.npmrc ~/.npmrc
cp ~/dotfiles/.yarnrc ~/.yarnrc
```

## 🛠️ Features

### Shell Configuration (Zsh)
- **Powerlevel10k** prompt with rainbow theme
- **Custom aliases** for Rails, SeleniumHub, and infra-config projects
- **SSH functions** for BrowserStack environments
- **Vault integration** for credential management
- **Development paths** for Android SDK, Java, Elasticsearch, etc.
- **Tool integrations** for NVM, RVM, Homebrew, etc.

### Window Management
- **AeroSpace** tiling window manager configuration
- **Tmux** with custom keybindings and plugins
- **Catppuccin** theme support

### Development Tools
- **Git** with LFS support
- **Node.js** with npm/yarn configuration
- **Ruby** with default gems
- **GitHub CLI** configuration

## 📋 Key Aliases & Functions

### Project Navigation
```bash
r          # cd ~/bscode/railsApp && code .
s          # cd ~/bscode/SeleniumHub && code .
i          # cd ~/bscode/infra-config && code .
```

### SSH Functions
```bash
winssh <ip>    # SSH to Windows machine via port 4022
macssh <ip>    # SSH to macOS machine via port 4022
mssh <ip>      # SSH to app user via port 4022
prodssh <ip>   # SSH to production via jump host
bssh           # Launch BrowserStack SSH manager
```

### Vault Integration
```bash
vault_login    # Login to Vault with GitHub token
ssl_cert       # Download SSL certificates from Vault
vault_creds    # Get commonly used credentials from Vault
```

### Utility Functions
```bash
nvml()         # Load NVM environment
rosetta()      # Switch to x86_64 architecture
txa()          # Attach to tmux session
tx             # tmux alias
```

## 🔧 Requirements

- **macOS** (tested on macOS Monterey and later)
- **Zsh** as default shell
- **Tmux** for terminal multiplexing
- **AeroSpace** for window management
- **Powerlevel10k** for Zsh prompt
- **Git** with LFS support
- **Node.js** and npm/yarn
- **Ruby** with RVM
- **Vault CLI** for credential management

## ⚠️ Important Notes

1. **SSH Keys**: The SSH private keys (`id_rsa`) are NOT included in this repository for security reasons. You'll need to set them up separately.

2. **Sensitive Data**: Files containing tokens or sensitive information (like `.vault-token`) are excluded.

3. **Backup**: Before installing, backup your existing dotfiles:
   ```bash
   mv ~/.zshrc ~/.zshrc.backup
   mv ~/.tmux.conf ~/.tmux.conf.backup
   # etc.
   ```

4. **Customization**: After installation, you may need to customize:
   - Git user email and name
   - Paths specific to your machine
   - API tokens and credentials

## 🔄 Syncing Changes

To sync changes back to this repository:

```bash
# Use the sync script
cd ~/dotfiles
chmod +x scripts/sync.sh
./scripts/sync.sh

# Or manually copy and commit
cp ~/.zshrc ~/dotfiles/
cp ~/.tmux.conf ~/dotfiles/
# ... other files
git add .
git commit -m "Update dotfiles"
git push origin main
```

## 📝 License

MIT License - Feel free to use these configurations as inspiration for your own setup.

## 🙏 Acknowledgments

- **Powerlevel10k** for the amazing Zsh prompt
- **AeroSpace** for the tiling window manager
- **Tmux** team for the terminal multiplexer
- **Homebrew** for package management
- **Oh My Zsh** framework for Zsh configuration