#!/bin/bash
source functions.sh

# Homebrew installation and coreutils
if ismac; then
	brew --version || /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"	
	brew install coreutils
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
	ln -sf "$(realpath ".vimrc")" ~/.vimrc
fi

# Kitty installation and configuration
if ask "Do you want to install Kitty and preferences?"; then
	if ismac; then
		# Homebrew Kitty installation
		brew install kitty
	elif [ "$(uname)" == "Linux" ]; then
		sudo apt install kitty
	fi
	# Configuration and preferences setup
	mkdir -p ~/.config/kitty/themes
	ln -sf "$(realpath "kitty/kitty.conf")" ~/.config/kitty/kitty.conf
	for theme in kitty/themes/*; do
		ln -sf "$(realpath ${theme})" ~/.config/kitty/themes/
	done
fi
