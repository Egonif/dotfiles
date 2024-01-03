#!/bin/bash

function ask() {
	read -p "$1 (Y/n): " response
	[ -z "$response" ] || [ "$response" = "y" ]
}

# Install Oh-My-Zsh
if ask "Do you want to install oh-my-zsh?"; then
	sh -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)"
fi

# Check what shell is being used
SH="${HOME}/.bashrc"
ZSHRC="${HOME}/.zshrc"
if [ -f "$ZSHRC" ]; then
	SH="$ZSHRC"
fi

# Add a blank line
echo >> "$SH"

# Ask for tools to be sourced
echo "Do you want $SH to source: "
for file in tools/*; do
    if [ -f "$file" ]; then
        if ask "$(basename "$file")?"; then
            echo "source $(realpath "$file")" >> "$SH"
        fi
    fi
done

# Vim conf
if ask "Do you want to install .vimrc?"; then
    ln -s "$(realpath ".vimrc")" ~/.vimrc
fi

# Zsh conf
if ask "Do you want to install .zshrc?"; then
    ln -s "$(realpath ".zshrc")" ~/.zshrc
fi
