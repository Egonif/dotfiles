#!/bin/bash
source functions.sh

# Check what shell is being used
SH="${HOME}/.bashrc"
ZSHRC="${HOME}/.zshrc"
if [ -f "$ZSHRC" ]; then
	SH="$ZSHRC"
fi

# Install Oh-My-Zsh
if ask "Do you want to install oh-my-zsh?"; then
	sh -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)"
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
	ln -sf "$(realpath ".vimrc")" ~/.vimrc
fi

# Kitty installation
./kitty/install.sh

# Powerlevel10k installation
git clone --depth=1 https://github.com/romkatv/powerlevel10k.git ~/powerlevel10k
echo 'source ~/powerlevel10k/powerlevel10k.zsh-theme' >>~/.zshrc
