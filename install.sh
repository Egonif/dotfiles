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

# Kitty installation and configuration
if ask "Do you want to install Kitty and preferences?"; then
	if [ "$(uname)" == "Darwin" ]; then
		# Homebrew check and installation
		brew --version || /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"	
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

# Powerlevel10k installation
if ask "Do you want to install powerlevel10k?"; then
	git clone --depth=1 https://github.com/romkatv/powerlevel10k.git ~/powerlevel10k
	echo 'source ~/powerlevel10k/powerlevel10k.zsh-theme' >>~/.zshrc
fi
