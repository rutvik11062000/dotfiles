#!/bin/bash

# Dotfiles Sync Script
# This script syncs changes from home directory back to the dotfiles repository

set -e

DOTFILES_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")/.." && pwd)"
HOME_DIR="$HOME"

echo "🔄 Syncing dotfiles from home directory to repository..."

# Function to copy file if it exists and is different
copy_if_changed() {
    local source="$1"
    local target="$2"

    if [ -f "$source" ]; then
        if [ ! -f "$target" ] || ! cmp -s "$source" "$target"; then
            echo "📄 Copying $(basename "$source")"
            cp "$source" "$target"
        else
            echo "✅ $(basename "$source") is up to date"
        fi
    else
        echo "⚠️ $source does not exist, skipping"
    fi
}

# Function to handle symlinks (copy the linked file's content)
handle_symlink() {
    local source="$1"
    local target="$2"

    if [ -L "$source" ]; then
        echo "🔗 $(basename "$source") is a symlink, copying linked content"
        # Read the actual file content and write to target
        cat "$source" > "$target"
    elif [ -f "$source" ]; then
        copy_if_changed "$source" "$target"
    else
        echo "⚠️ $source does not exist, skipping"
    fi
}

echo ""
echo "📝 Syncing shell configuration files..."

# Shell configuration files
handle_symlink "$HOME_DIR/.zshrc" "$DOTFILES_DIR/.zshrc"
handle_symlink "$HOME_DIR/.p10k.zsh" "$DOTFILES_DIR/.p10k.zsh"
handle_symlink "$HOME_DIR/.bashrc" "$DOTFILES_DIR/.bashrc"
handle_symlink "$HOME_DIR/.bash_profile" "$DOTFILES_DIR/.bash_profile"
handle_symlink "$HOME_DIR/.profile" "$DOTFILES_DIR/.profile"
handle_symlink "$HOME_DIR/.zprofile" "$DOTFILES_DIR/.zprofile"
handle_symlink "$HOME_DIR/.zlogin" "$DOTFILES_DIR/.zlogin"

echo ""
echo "🖥️ Syncing development tool configuration..."

# Development tools
handle_symlink "$HOME_DIR/.tmux.conf" "$DOTFILES_DIR/.tmux.conf"
handle_symlink "$HOME_DIR/.aerospace.toml" "$DOTFILES_DIR/.aerospace.toml"
handle_symlink "$HOME_DIR/.gitconfig" "$DOTFILES_DIR/.gitconfig"

echo ""
echo "📦 Syncing package manager configuration..."

# Package manager files
copy_if_changed "$HOME_DIR/.default-gems" "$DOTFILES_DIR/.default-gems"
copy_if_changed "$HOME_DIR/.tool-versions" "$DOTFILES_DIR/.tool-versions"
copy_if_changed "$HOME_DIR/.npmrc" "$DOTFILES_DIR/.npmrc"
copy_if_changed "$HOME_DIR/.yarnrc" "$DOTFILES_DIR/.yarnrc"

echo ""
echo "⚙️ Syncing application configuration..."

# GitHub CLI configuration
if [ -d "$HOME_DIR/.config/gh" ]; then
    mkdir -p "$DOTFILES_DIR/config"
    echo "📁 Syncing GitHub CLI configuration"
    rsync -av --delete "$HOME_DIR/.config/gh/" "$DOTFILES_DIR/config/gh/"
else
    echo "⚠️ GitHub CLI configuration not found"
fi

# SSH configuration (copy only config, not keys)
if [ -f "$HOME_DIR/.ssh/config" ]; then
    mkdir -p "$DOTFILES_DIR/ssh"
    copy_if_changed "$HOME_DIR/.ssh/config" "$DOTFILES_DIR/ssh/config"
else
    echo "⚠️ SSH config not found"
fi

echo ""
echo "📋 Checking for any new configuration files..."

# Check for potentially missed dot files in home directory
for file in "$HOME_DIR"/.*; do
    basename_file=$(basename "$file")

    # Skip certain files/directories
    case "$basename_file" in
        .|..|.git|.DS_Store|.local|.cache|.npm|.node_repl_history|.bash_history|.zsh_history|.python_history|.psql_history|.mysql_history|.irb_history|.lesshst|.wget-hsts|.zcompdump*|.vault-token|.CFUserTextEncoding|.viminfo|.viminfo.tmp|.clickhouse-client-history|.influx_history|.rediscli_history|.cshrc|.mkshrc|.tcshrc|.mobileprovision|.irb-history)
            continue
            ;;
        *.backup|*.bak|*.pysave)
            continue
            ;;
    esac

    # Check if it's a regular file that might be a config
    if [ -f "$file" ]; then
        # Check if it's a common config file
        if [[ "$basename_file" =~ \.(toml|conf|config|json|yaml|yml|rc)$ ]] || \
           [[ "$basename_file" =~ ^(profile|bashrc|zshrc|zprofile|zlogin|gitconfig|tmux\.conf|vimrc|editorconfig|curlrc|wgetrc|inputrc|dir_colors|dircolors|muttrc|signature|exrc|netrc|gemrc)$ ]]; then

            target_file="$DOTFILES_DIR/$basename_file"
            if [ ! -f "$target_file" ]; then
                echo "🆕 Found new config file: $basename_file"
                copy_if_changed "$file" "$target_file"
            fi
        fi
    fi
done

echo ""
echo "✅ Sync completed!"
echo ""
echo "📋 Review the changes:"
echo "cd $DOTFILES_DIR && git status"
echo ""
echo "💡 To commit and push changes:"
echo "cd $DOTFILES_DIR"
echo "git add ."
echo "git commit -m \"Update dotfiles - $(date)\""
echo "git push origin main"