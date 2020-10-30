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


echo "## Setup applications ##"
create_symlink "$HOME/dotfiles/shared/display/display-laptop.desktop" "$HOME/.local/share/applications/display-laptop.desktop"
create_symlink "$HOME/dotfiles/shared/display/display-hdmi.desktop" "$HOME/.local/share/applications/display-hdmi.desktop"
create_symlink "$HOME/dotfiles/shared/display/display-extend.desktop" "$HOME/.local/share/applications/display-extend.desktop"
create_symlink "$HOME/dotfiles/shared/display/audio-laptop.desktop" "$HOME/.local/share/applications/audio-laptop.desktop"
create_symlink "$HOME/dotfiles/shared/display/audio-hdmi.desktop" "$HOME/.local/share/applications/audio-hdmi.desktop"
create_symlink "$HOME/dotfiles/shared/display/audio-jabra.desktop" "$HOME/.local/share/applications/audio-jabra.desktop"

create_symlink "$HOME/dotfiles/shared/applications/microphone.desktop" "$HOME/.local/share/applications/microphone.desktop"
create_symlink "$HOME/dotfiles/shared/applications/ocr-de.desktop" "$HOME/.local/share/applications/ocr-de.desktop"
create_symlink "$HOME/dotfiles/shared/applications/ocr.desktop" "$HOME/.local/share/applications/ocr.desktop"
create_symlink "$HOME/dotfiles/shared/applications/screenshot.desktop" "$HOME/.local/share/applications/screenshot.desktop"
create_symlink "$HOME/dotfiles/shared/applications/television.desktop" "$HOME/.local/share/applications/television.desktop"
create_symlink "$HOME/dotfiles/shared/applications/video.desktop" "$HOME/.local/share/applications/video.desktop"
create_symlink "$HOME/dotfiles/shared/applications/startup-laptop.desktop" "$HOME/.local/share/applications/startup-laptop.desktop"
create_symlink "$HOME/dotfiles/shared/applications/startup-keyboard.desktop" "$HOME/.local/share/applications/startup-keyboard.desktop"

create_symlink "$HOME/dotfiles/shared/themes/rofi-theme-Monokai.rasi" "$HOME/.config/rofi/rofi-theme-Monokai.rasi"
create_symlink "$HOME/dotfiles/shared/themes/tasks-monokai.hidden-tmTheme" "$HOME/.config/sublime-text-3/Packages/PlainTasks/tasks-monokai.hidden-tmTheme"
create_symlink "$HOME/dotfiles/shared/themes/ayu-dark.sublime-color-scheme" "$HOME/.config/sublime-text-3/Packages/ayu/ayu-dark.sublime-color-scheme"

create_symlink "$HOME/dotfiles/shared/perl/keyboard-select" "/usr/lib/urxvt/perl/keyboard-select"
create_symlink "$HOME/dotfiles/shared/bash/sxiv-key.sh" "$HOME/.config/sxiv/exec/key-handler"
create_symlink "$HOME/dotfiles/shared/tmux/tmux.conf" "$HOME/.tmux.conf"
create_symlink "$HOME/dotfiles/shared/python/file_format.py" "$HOME/.local/bin/ff"
create_symlink "$HOME/dotfiles/shared/python/ipython.py" "$HOME/.ipython/profile_default/ipython_config.py"
create_symlink "$HOME/dotfiles/shared/config/micro-bindings.json" "$HOME/.config/micro/bindings.json"
create_symlink "$HOME/dotfiles/shared/config/dunstrc" "$HOME/.config/dunst/dunstrc"
create_symlink "$HOME/dotfiles/shared/config/rofi" "$HOME/.config/rofi/config"
create_symlink "$HOME/dotfiles/shared/Xdefaults" "$HOME/.Xdefaults"
create_symlink "$HOME/dotfiles/shared/python/ipython-functions.py" "$HOME/.ipython/profile_default/startup/ipython-functions.py"