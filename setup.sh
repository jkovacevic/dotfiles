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
create_symlink "$HOME/dotfiles/zshrc.sh" "$HOME/.zshrc"
create_symlink "$HOME/dotfiles/i3.md" "$HOME/.config/i3/config"
create_symlink "$HOME/dotfiles/i3status" "$HOME/.config/i3status/config"
create_symlink "$HOME/dotfiles/i3blocks" "$HOME/.config/i3blocks/config"
create_symlink "$HOME/dotfiles/ipython.py" "$HOME/.ipython/profile_default/ipython_config.py"
create_symlink "$HOME/dotfiles/sublime-settings.json" "$HOME/.config/sublime-text-3/Packages/User/Preferences.sublime-settings"
create_symlink "$HOME/dotfiles/sublime-keymap.json" "$HOME/.config/sublime-text-3/Packages/User/Default (Linux).sublime-keymap"
create_symlink "$HOME/dotfiles/sublime-history.json" "$HOME/.config/sublime-text-3/Packages/User/LocalHistory.sublime-settings"
create_symlink "$HOME/dotfiles/Xdefaults" "$HOME/.Xdefaults"
create_symlink "$HOME/dotfiles/perl/keyboard-select" "/usr/lib/urxvt/perl/keyboard-select"
create_symlink "$HOME/dotfiles/dmenu-search/dmenu_search.sh" "/usr/local/bin/dmenu_search"
create_symlink "$HOME/dotfiles/bash/create_ss/ss.sh" "/usr/local/bin/ss"
create_symlink "$HOME/dotfiles/bash/sxiv-key-handler/sxiv-key-handler.sh" "$HOME/.config/sxiv/exec/key-handler"
create_symlink "$HOME/dotfiles/python/file_format.py" "/usr/local/bin/file_format.py"