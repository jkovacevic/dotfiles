#!/bin/bash

function create_symlink {
	dotfile="$1"
	target="$2"
	echo "Creating symlink $target -> $dotfile"
	if [ -f "$target" ] || [ -L "$target" ]; then
		sudo rm "$target"
	fi;
	
	sudo ln -s "$dotfile" "$target"
}

echo "## Setup dotfiles ##"
create_symlink "$HOME/dotfiles/startup" "/usr/bin/startup"
create_symlink "$HOME/dotfiles/zsh/zshrc.zsh" "$HOME/.zshrc"
create_symlink "$HOME/dotfiles/i3" "$HOME/.config/i3/config"
create_symlink "$HOME/dotfiles/i3status" "$HOME/.config/i3status/config"
create_symlink "$HOME/dotfiles/rofi" "$HOME/.config/rofi/config"
create_symlink "$HOME/dotfiles/tmux" "$HOME/.tmux.conf"
create_symlink "$HOME/dotfiles/themes/rofi-theme-Monokai.rasi" "$HOME/.config/rofi/rofi-theme-Monokai.rasi"
create_symlink "$HOME/dotfiles/themes/tasks-monokai.hidden-tmTheme" "$HOME/.config/sublime-text-3/Packages/PlainTasks/tasks-monokai.hidden-tmTheme"
create_symlink "$HOME/dotfiles/Xdefaults" "$HOME/.Xdefaults"
create_symlink "$HOME/dotfiles/polybar" "$HOME/.config/polybar/config"
create_symlink "$HOME/dotfiles/bash/screenshot.sh" "/usr/local/bin/screenshot"
create_symlink "$HOME/dotfiles/bash/video.sh" "/usr/local/bin/video"
create_symlink "$HOME/dotfiles/bash/microphone.sh" "/usr/local/bin/microphone"
create_symlink "$HOME/dotfiles/bash/ocr.sh" "/usr/local/bin/ocr"
create_symlink "$HOME/dotfiles/bash/ocr-de.sh" "/usr/local/bin/ocr-de"
create_symlink "$HOME/dotfiles/bash/tmp.sh" "/usr/local/bin/tmp"
create_symlink "$HOME/dotfiles/bash/sxiv-key.sh" "$HOME/.config/sxiv/exec/key-handler"
create_symlink "$HOME/dotfiles/python/ipython.py" "$HOME/.ipython/profile_default/ipython_config.py"
create_symlink "$HOME/dotfiles/python/file_format.py" "/usr/local/bin/ff"
create_symlink "$HOME/dotfiles/perl/keyboard-select" "/usr/lib/urxvt/perl/keyboard-select"
create_symlink "$HOME/dotfiles/sublime/User" "$HOME/.config/sublime-text-3/Packages/User"
create_symlink "$HOME/.config/sublime-text-3/.sublime/Local History" "$HOME/.sublime-history"
create_symlink "$HOME/dotfiles/applications/screenshot.desktop" "$HOME/.local/share/applications/screenshot.desktop"
create_symlink "$HOME/dotfiles/applications/video.desktop" "$HOME/.local/share/applications/video.desktop"
create_symlink "$HOME/dotfiles/applications/microphone.desktop" "$HOME/.local/share/applications/microphone.desktop"
create_symlink "$HOME/dotfiles/applications/ocr.desktop" "$HOME/.local/share/applications/ocr.desktop"
create_symlink "$HOME/dotfiles/applications/ocr-de.desktop" "$HOME/.local/share/applications/ocr-de.desktop"