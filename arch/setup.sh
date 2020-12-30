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


echo "## Setup dotfiles ##"
create_symlink "$HOME/dotfiles/arch/zsh/zshrc.zsh" "$HOME/.zshrc"
create_symlink "$HOME/dotfiles/arch/i3.md" "$HOME/.config/i3/config"
create_symlink "$HOME/dotfiles/arch/polybar.ini" "$HOME/.config/polybar/config"
