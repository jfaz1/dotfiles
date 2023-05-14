#!/bin/sh

# Pull latest p10k
rm -rf ~/.config/powerlevel10k
git clone --depth=1 https://github.com/romkatv/powerlevel10k.git ~/.config/powerlevel10k

# Ensure directories exist
mkdir -p ~/.config/wezterm
mkdir -p ~/.config/helix
mkdir -p ~/.config/helix/themes

# Remove old configs
rm -f ~/.config/wezterm/wezterm.lua
rm -f ~/.config/helix/config.tml
rm -f ~/.zshrc
rm -f ~/.p10k.zsh

# Create new symlinks
ln -f wezterm.lua ~/.config/wezterm/wezterm.lua
ln -f config.toml ~/.config/helix/config.toml
ln -f jfaz.toml ~/.config/helix/themes/jfaz.toml
ln -f .zshrc ~/.zshrc
ln -f .p10k.zsh ~/.p10k.zsh

unameOut="$(uname -s)"
case "${unameOut}" in
    Linux*)     machine=Linux;;
    Darwin*)    machine=Mac;;
    CYGWIN*)    machine=Cygwin;;
    MINGW*)     machine=MinGw;;
    *)          machine="UNKNOWN:${unameOut}"
esac

if [ $machine != "Linux" ] && [ $machine != "Mac" ]; then
	rm -f ~/.bashrc
	ln -f .bashrc ~/.bashrc
fi

if [ $machine == "Linux" ]; then
	# Razer poll-rate
	mkdir -p ~/.config/systemd/user/
	cp -f razer-poll-rate.service ~/.config/systemd/user/
	systemctl --user enable razer-poll-rate.service
	systemctl --user start razer-poll-rate.service
	
	# Kitty
	# rm ~/.config/kitty/current-theme.conf
	# wget https://raw.githubusercontent.com/catppuccin/kitty/main/diff-macchiato.conf -O ~/.config/kitty/current-theme.conf
fi

# Create new custom configs
touch ~/.user_zshrc
