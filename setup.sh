#!/bin/sh

# Remove old configs
rm ~/.config/wezterm/wezterm.lua
rm ~/.zshrc
rm ~/.p10k.zsh
rm ~/.bashrc

# Create new symlinks
ln -f ./wezterm.lua ~/.config/wezterm/wezterm.lua
ln -f ./.zshrc ~/.zshrc
ln -f ./.p10k.zsh ~/.p10k.zsh
ln -f ./.bashrc ~/.bashrc

# Pull latest p10k
rm -rf ~/.config/powerlevel10k
git --depth=1 https://github.com/romkatv/powerlevel10k.git ~/.config/powerlevel10k

# Create new custom configs
touch ~/.user_zshrc

