#!/usr/bin/env bash

echo "### Starting dotfiles installation"

# Get the directory this script is in
SCRIPT_DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" >/dev/null 2>&1 && pwd )"

# Install oh-my-zsh if not already installed
echo "### Installing oh-my-zsh"
sh -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)" 1> /dev/null

# Create symlinks of each dot file to home directory
echo "### Linking from $HOME to dotfiles" 
ln -sf $SCRIPT_DIR/.vimrc $HOME/.vimrc
ln -sf $SCRIPT_DIR/.zshrc $HOME/.zshrc
ln -sf $SCRIPT_DIR/.vimrc $HOME/.tmux.conf

echo "### Done!"