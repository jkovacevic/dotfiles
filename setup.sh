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
create_symlink "$HOME/dotfiles/zshrc" "$HOME/.zshrc"
create_symlink "$HOME/dotfiles/i3" "$HOME/.config/i3/config"
create_symlink "$HOME/dotfiles/i3status" "$HOME/.config/i3status/config"
create_symlink "$HOME/dotfiles/rofi" "$HOME/.config/rofi/config"
create_symlink "$HOME/dotfiles/themes/arc-red-dark.rasi" "$HOME/.config/rofi/arc-red-dark.rasi"
create_symlink "$HOME/dotfiles/Xdefaults" "$HOME/.Xdefaults"
create_symlink "$HOME/dotfiles/polybar" "$HOME/.config/polybar/config"
create_symlink "$HOME/dotfiles/bash/screenshot.sh" "/usr/local/bin/screenshot"
create_symlink "$HOME/dotfiles/bash/video.sh" "/usr/local/bin/video"
create_symlink "$HOME/dotfiles/bash/ocr.sh" "/usr/local/bin/ocr"
create_symlink "$HOME/dotfiles/bash/scrap.sh" "/usr/local/bin/scrap"
create_symlink "$HOME/dotfiles/bash/sxiv-key.sh" "$HOME/.config/sxiv/exec/key-handler"
create_symlink "$HOME/dotfiles/python/ipython.py" "$HOME/.ipython/profile_default/ipython_config.py"
create_symlink "$HOME/dotfiles/python/file_format.py" "/usr/local/bin/file_format.py"
create_symlink "$HOME/dotfiles/perl/keyboard-select" "/usr/lib/urxvt/perl/keyboard-select"
create_symlink "$HOME/dotfiles/sublime/sublime-settings.json" "$HOME/.config/sublime-text-3/Packages/User/Preferences.sublime-settings"
create_symlink "$HOME/dotfiles/sublime/sublime-keymap.json" "$HOME/.config/sublime-text-3/Packages/User/Default (Linux).sublime-keymap"
create_symlink "$HOME/dotfiles/sublime/sublime-history.json" "$HOME/.config/sublime-text-3/Packages/User/LocalHistory.sublime-settings"
create_symlink "$HOME/dotfiles/applications/screenshot.desktop" "$HOME/.local/share/applications/screenshot.desktop"
create_symlink "$HOME/dotfiles/applications/video.desktop" "$HOME/.local/share/applications/video.desktop"
create_symlink "$HOME/dotfiles/applications/ocr.desktop" "$HOME/.local/share/applications/ocr.desktop"