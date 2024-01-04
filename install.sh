#!/bin/bash

ask() {
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
	ln -sf "$(realpath ".vimrc")" ~/.vimrc
fi

# Alacritty conf
if ask "Do you want to install alacritty.toml?"; then
	mkdir -p .config/alacritty
	ln -sf "$(realpath "alacritty.toml")" ~/.config/alacritty/alacritty.toml
fi

# Install packages and apps
if ask "Do you want to install useful packages and apps?"; then
	if [ "$(uname)" == "Darwin" ]; then
		sudo -v #Give sudo privileges ahead of time, so that we hopefully only have to enter a password once
		cd ~ #Moving to home directory at the beginning of the process
		
		# Installing Oh-My-Zsh (Color Preferences)
		sh -c "$(curl -fsSL https://raw.githubusercontent.com/robbyrussell/oh-my-zsh/master/tools/install.sh)"
		
		# Installing MacOS Apps, via Homebrew, Caks, & The App Store
		brew=(
		    bash
		    cargo
		    cask
		    cava
		    cmake
		    cmatrix
		    curl
		    ffmpeg
		    flac
		    fzf
		    git
		    make
		    mas
		    mp3gain
		    mp3splt
		    mpv
		    ncdu
		    neofetch
		    nmap
		    node
		    npm
		    pip
		    python
		    ranger
		    ruby
		    rust
		    sox
		    speedtest
		    tmux
		    tree
		    yt-dlp
		)
		cask=(
		    alacritty
		    anydesk
		    appcleaner
		    audacity
		    arc
		    balenaetcher
		    bitwarden
		    blackhole-2ch
		    deepl
		    discord
		    figma
		    firefox
		    handbrake
		    iterm2
		    jazzup
		    librecad
		    obs
		    omnidisksweeper
		    signal
		    sonobus
		    spectacle
		    spotify
		    reaper
		    vlc
		) # GUI apps that install with cask
		mas=(
		    1147396723  # WhatsApp        (2.2149.4)
		    1423210932  # Flow            (2.7.7)
		    1452453066  # Hidden Bar      (1.8)
		    1494457680  # Smash           (1.1.1)
		    1561724782  # Uninstaller     (1.6.7)
		    409183694   # Keynote         (11.1)
		    409201541   # Pages           (11.0)
		    409203825   # Numbers         (11.0)
		    425424353   # The Unarchiver  (4.3.3)
		) # Mac App Store apps I install
		# npm=(
		
		# )
		
		# Update the version of Homebrew
		brew upgrade
		
		brew install "${brew[@]}"        # Homebrew App Installer
		brew install "${cask[@]}"--cask  # Casks Installer
		mas install "${mas[@]}"          # Mac App Store Installer
		# npm install ${npm[@]}           # Install npm apps	
	fi
fi
