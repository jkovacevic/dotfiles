#!/bin/bash
create_symlink() {
    dotfile="$1"
    target="$2"
    echo "Creating symlink $target -> $dotfile"
    if [ -f "$target" ] || [ -L "$target" ]; then
        sudo rm "$target"
    fi;
    
    sudo ln -s "$dotfile" "$target"
}


echo "## Setup dotfiles ##"
create_symlink "$HOME/dotfiles/zsh/zshrc.zsh" "$HOME/.zshrc"
create_symlink "$HOME/dotfiles/i3" "$HOME/.config/i3/config"
create_symlink "$HOME/dotfiles/i3status" "$HOME/.config/i3status/config"
create_symlink "$HOME/dotfiles/rofi" "$HOME/.config/rofi/config"
create_symlink "$HOME/dotfiles/themes/rofi-theme-Monokai.rasi" "$HOME/.config/rofi/rofi-theme-Monokai.rasi"
create_symlink "$HOME/dotfiles/themes/tasks-monokai.hidden-tmTheme" "$HOME/.config/sublime-text-3/Packages/PlainTasks/tasks-monokai.hidden-tmTheme"
create_symlink "$HOME/dotfiles/Xdefaults" "$HOME/.Xdefaults"
create_symlink "$HOME/dotfiles/polybar" "$HOME/.config/polybar/config"
create_symlink "$HOME/dotfiles/bash/screenshot.sh" "$HOME/.local/bin/screenshot"
create_symlink "$HOME/dotfiles/bash/video.sh" "$HOME/.local/bin/video"
create_symlink "$HOME/dotfiles/bash/microphone.sh" "$HOME/.local//bin/microphone"
create_symlink "$HOME/dotfiles/bash/ocr.sh" "$HOME/.local/bin/ocr"
create_symlink "$HOME/dotfiles/bash/ocr-de.sh" "$HOME/.local/bin/ocr-de"
create_symlink "$HOME/dotfiles/bash/sxiv-key.sh" "$HOME/.config/sxiv/exec/key-handler"
create_symlink "$HOME/dotfiles/python/ipython.py" "$HOME/.ipython/profile_default/ipython_config.py"
create_symlink "$HOME/dotfiles/python/file_format.py" "$HOME/.local//bin/ff"
create_symlink "$HOME/dotfiles/sublime/User" "$HOME/.config/sublime-text-3/Packages/User"
create_symlink "$HOME/.config/sublime-text-3/.sublime/Local History" "$HOME/.sublime-history"