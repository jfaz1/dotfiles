#!/bin/sh

# Pull latest p10k
rm -rf ~/.config/powerlevel10k
git clone --depth=1 https://github.com/romkatv/powerlevel10k.git ~/.config/powerlevel10k

# Remove old configs
rm -f ~/.config/wezterm/wezterm.lua
rm -f ~/.zshrc
rm -f ~/.p10k.zsh
rm -f ~/.bashrc

# Create new symlinks
ln -f ./wezterm.lua ~/.config/wezterm/wezterm.lua
ln -f ./.zshrc ~/.zshrc
ln -f ./.p10k.zsh ~/.p10k.zsh
ln -f ./.bashrc ~/.bashrc

# Create new custom configs
touch ~/.user_zshrc

