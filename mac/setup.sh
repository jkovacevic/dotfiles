#!/bin/bash
create_symlink() {
    dotfile="$1"
    target="$2"
    echo "Creating symlink $target -> $dotfile"
    if [ -f "$target" ] || [ -L "$target" ]; then
        sudo rm "$target"
    fi;
    
	# Create folders in case they do not exist
	mkdir -p $(dirname "${target}")
    sudo ln -s "$dotfile" "$target"
}


echo "## Setup Dotfiles"
create_symlink "$HOME/dotfiles/mac/zsh/zshrc.zsh" "$HOME/.zshrc"
create_symlink "$HOME/dotfiles/mac/hammerspoon.lua" "$HOME/.hammerspoon/init.lua"
create_symlink "$HOME/dotfiles/mac/karabiner.json" "$HOME/.config/karabiner/karabiner.json"
create_symlink "$HOME/dotfiles/mac/tmux.conf" "$HOME/.tmux.conf"
create_symlink "$HOME/dotfiles/mac/micro-bindings.json" "$HOME/.config/micro/bindings.json"
create_symlink "$HOME/dotfiles/shared/themes/nord-tc.micro" "$HOME/.config/micro/colorschemes/nord-tc.micro"