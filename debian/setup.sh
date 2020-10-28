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
create_symlink "$HOME/dotfiles/debian/zsh/zshrc.zsh" "$HOME/.zshrc"
create_symlink "$HOME/dotfiles/debian/i3" "$HOME/.config/i3/config"
create_symlink "$HOME/dotfiles/debian/i3status" "$HOME/.config/i3status/config"
create_symlink "$HOME/dotfiles/debian/rofi" "$HOME/.config/rofi/config"
create_symlink "$HOME/dotfiles/debian/themes/ayu-dark.sublime-color-scheme" "$HOME/.config/sublime-text-3/Packages/ayu/ayu-dark.sublime-color-scheme"
create_symlink "$HOME/dotfiles/debian/Xdefaults" "$HOME/.Xdefaults"
create_symlink "$HOME/dotfiles/debian/polybar" "$HOME/.config/polybar/config"
create_symlink "$HOME/dotfiles/debian/bash/screenshot.sh" "$HOME/.local/bin/screenshot"
create_symlink "$HOME/dotfiles/debian/bash/video.sh" "$HOME/.local/bin/video"
create_symlink "$HOME/dotfiles/debian/bash/microphone.sh" "$HOME/.local//bin/microphone"
create_symlink "$HOME/dotfiles/debian/bash/ocr.sh" "$HOME/.local/bin/ocr"
create_symlink "$HOME/dotfiles/debian/bash/ocr-de.sh" "$HOME/.local/bin/ocr-de"
create_symlink "$HOME/dotfiles/debian/bash/sxiv-key.sh" "$HOME/.config/sxiv/exec/key-handler"
create_symlink "$HOME/dotfiles/debian/sublime/User" "$HOME/.config/sublime-text-3/Packages/User"
create_symlink "$HOME/.config/sublime-text-3/.sublime/Local History" "$HOME/.sublime-history"