#!/bin/bash

# Dotfiles Setup Script
# This script sets up symbolic links and copies configuration files

set -e

DOTFILES_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")/.." && pwd)"
BACKUP_DIR="$HOME/dotfiles-backup-$(date +%Y%m%d-%H%M%S)"

echo "🚀 Setting up Rutvik's dotfiles..."
echo "Dotfiles directory: $DOTFILES_DIR"
echo "Backup directory: $BACKUP_DIR"

# Create backup directory
mkdir -p "$BACKUP_DIR"

# Function to create backup and link
backup_and_link() {
    local source="$1"
    local target="$2"
    local backup_file="$BACKUP_DIR/$(basename "$target")"

    if [ -e "$target" ] && [ ! -L "$target" ]; then
        echo "📦 Backing up $target to $backup_file"
        mv "$target" "$backup_file"
    elif [ -L "$target" ]; then
        echo "🔗 Removing existing symlink $target"
        rm "$target"
    fi

    echo "🔗 Linking $source -> $target"
    ln -sf "$source" "$target"
}

# Function to copy file with backup
backup_and_copy() {
    local source="$1"
    local target="$2"
    local backup_file="$BACKUP_DIR/$(basename "$target")"

    if [ -e "$target" ] && [ ! -L "$target" ]; then
        echo "📦 Backing up $target to $backup_file"
        cp "$target" "$backup_file"
    elif [ -L "$target" ]; then
        echo "🔗 Removing existing symlink $target"
        rm "$target"
    fi

    echo "📄 Copying $source -> $target"
    cp "$source" "$target"
}

echo ""
echo "🔗 Setting up shell configuration files..."

# Shell configuration files (symlinks for easy updates)
backup_and_link "$DOTFILES_DIR/.zshrc" "$HOME/.zshrc"
backup_and_link "$DOTFILES_DIR/.p10k.zsh" "$HOME/.p10k.zsh"
backup_and_link "$DOTFILES_DIR/.bashrc" "$HOME/.bashrc"
backup_and_link "$DOTFILES_DIR/.bash_profile" "$HOME/.bash_profile"
backup_and_link "$DOTFILES_DIR/.profile" "$HOME/.profile"
backup_and_link "$DOTFILES_DIR/.zprofile" "$HOME/.zprofile"
backup_and_link "$DOTFILES_DIR/.zlogin" "$HOME/.zlogin"

echo ""
echo "🖥️ Setting up development tool configuration..."

# Development tools (symlinks)
backup_and_link "$DOTFILES_DIR/.tmux.conf" "$HOME/.tmux.conf"
backup_and_link "$DOTFILES_DIR/.aerospace.toml" "$HOME/.aerospace.toml"
backup_and_link "$DOTFILES_DIR/.gitconfig" "$HOME/.gitconfig"

echo ""
echo "📦 Setting up package manager configuration..."

# Package manager files (copies to allow local modifications)
backup_and_copy "$DOTFILES_DIR/.default-gems" "$HOME/.default-gems"
backup_and_copy "$DOTFILES_DIR/.tool-versions" "$HOME/.tool-versions"
backup_and_copy "$DOTFILES_DIR/.npmrc" "$HOME/.npmrc"
backup_and_copy "$DOTFILES_DIR/.yarnrc" "$HOME/.yarnrc"

echo ""
echo "⚙️ Setting up application configuration..."

# Config directory
mkdir -p "$HOME/.config"
if [ -d "$DOTFILES_DIR/config/gh" ]; then
    if [ -d "$HOME/.config/gh" ] && [ ! -L "$HOME/.config/gh" ]; then
        mv "$HOME/.config/gh" "$BACKUP_DIR/gh"
    fi
    echo "🔗 Linking GitHub CLI configuration"
    ln -sf "$DOTFILES_DIR/config/gh" "$HOME/.config/gh"
fi

# SSH configuration
mkdir -p "$HOME/.ssh"
if [ -f "$DOTFILES_DIR/ssh/config" ]; then
    backup_and_copy "$DOTFILES_DIR/ssh/config" "$HOME/.ssh/config"
    chmod 600 "$HOME/.ssh/config"
fi

echo ""
echo "🔧 Setting up scripts directory..."
mkdir -p "$HOME/.local/bin"

# Create sync script alias
echo "Creating dotfiles sync helper..."
cat > "$HOME/.local/bin/dotfiles-sync" << 'EOF'
#!/bin/bash
DOTFILES_DIR="$HOME/dotfiles"
cd "$DOTFILES_DIR"
./scripts/sync.sh
EOF
chmod +x "$HOME/.local/bin/dotfiles-sync"

# Add to PATH if not already there
if ! echo "$PATH" | grep -q "$HOME/.local/bin"; then
    echo "export PATH=\"\$PATH:$HOME/.local/bin\"" >> "$HOME/.zshrc.local" 2>/dev/null || {
        echo "# Local additions" > "$HOME/.zshrc.local"
        echo "export PATH=\"\$PATH:$HOME/.local/bin\"" >> "$HOME/.zshrc.local"
    }
fi

echo ""
echo "✅ Setup complete!"
echo ""
echo "📋 Next steps:"
echo "1. Restart your shell or run 'source ~/.zshrc'"
echo "2. Review and customize configuration files as needed"
echo "3. Set up your SSH keys (they are not included in this repo)"
echo "4. Configure any additional tools or credentials"
echo ""
echo "📦 Your original files have been backed up to: $BACKUP_DIR"
echo ""
echo "💡 To sync changes back to this repository, run: dotfiles-sync"