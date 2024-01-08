#!/bin/bash
source ../functions.sh

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
	cp themes/* ~/.config/kitty/themes/
fi
