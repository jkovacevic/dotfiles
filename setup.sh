#!/bin/bash
create_symlink() {
    dotfile="$1"
    target="$2"
    echo "Creating symlink $target -> $dotfile"
    if [ -f "$target" ] || [ -L "$target" ]; then
        rm "$target"
    fi;
	
    mkdir -p $(dirname "${target}")
    ln -s "$dotfile" "$target"
}

echo "# Setup configuration"
create_symlink "$HOME/dotfiles/zsh/zshrc.zsh" "$HOME/.zshrc"
create_symlink "$HOME/dotfiles/i3/i3.ini" "$HOME/.config/i3/config"
create_symlink "$HOME/dotfiles/zsh/zprofile.zsh" "$HOME/.zprofile"
create_symlink "$HOME/dotfiles/polybar/polybar.ini" "$HOME/.config/polybar/config"
create_symlink "$HOME/dotfiles/rofi/rofi.rasi" "$HOME/.config/rofi/config.rasi"
create_symlink "$HOME/dotfiles/urxvt/Xdefaults" "$HOME/.Xdefaults"
create_symlink "$HOME/dotfiles/tmux/tmux.conf" "$HOME/.tmux.conf"
create_symlink "$HOME/dotfiles/dunst/dunstrc" "$HOME/.config/dunst/dunstrc"
create_symlink "$HOME/dotfiles/micro/micro-bindings.json" "$HOME/.config/micro/bindings.json"
create_symlink "$HOME/dotfiles/vscode/settings.json" "$HOME/.config/VSCodium/User/settings.json"
create_symlink "$HOME/dotfiles/vscode/keybindings.json" "$HOME/.config/VSCodium/User/keybindings.json"
create_symlink "$HOME/dotfiles/vscode/tasks.json" "$HOME/.config/VSCodium/User/tasks.json"
create_symlink "$HOME/dotfiles/htop/htoprc.ini" "$HOME/.config/htop/htoprc"

echo "# Setup Scripts"
create_symlink "$HOME/dotfiles/bash/mount-hdd.sh" "$HOME/script/mount-hdd"
create_symlink "$HOME/dotfiles/python/file-format.py" "$HOME/script/ff"

echo "# Setup IPython"
create_symlink "$HOME/dotfiles/python/ipy-setup.py" "$HOME/.ipython/profile_default/ipython_config.py"
create_symlink "$HOME/dotfiles/python/ipy-copy-text.py" "$HOME/.ipython/profile_default/startup/copy-text.py"
create_symlink "$HOME/dotfiles/python/ipy-edit-history.py" "$HOME/.ipython/profile_default/startup/edit-history.py"

echo "# Setup Themes"
create_symlink "$HOME/dotfiles/themes/rofi-theme.rasi" "$HOME/.config/rofi/rofi-theme.rasi"
create_symlink "$HOME/dotfiles/themes/nord-tc.micro" "$HOME/.config/micro/colorschemes/nord-tc.micro"
create_symlink "$HOME/dotfiles/vscode/ws-light-color-theme.json" "$HOME/.vscode-oss/extensions/septwong.vscode-webstorm-theme-1.0.3-universal/themes/ws-light-color-theme.json"

echo "$ Setup Terminal"
create_symlink "$HOME/dotfiles/terminal/ghostty.ini" "$HOME/.config/ghostty/config"

echo "# Setup Claude"
create_symlink "$HOME/dotfiles/claude/settings.json" "$HOME/.claude/settings.json"
create_symlink "$HOME/dotfiles/claude/hooks" "$HOME/.claude/hooks"