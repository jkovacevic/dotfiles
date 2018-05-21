echo "Creating symlinks for configuration files."
echo "i3wm"
rm $HOME/.config/i3/config; ln -s $HOME/dotfiles/i3.md $HOME/.config/i3/config;

echo "ipython"
rm $HOME/.ipython/profile_default/ipython_config.py; ln -s $HOME/dotfiles/ipython.py $HOME/.ipython/profile_default/ipython_config.py;

echo "sublime text"
rm $HOME/.config/sublime-text-3/Packages/User/Preferences.sublime-settings; ln -s $HOME/dotfiles/sublime-settings.json $HOME/.config/sublime-text-3/Packages/User/Preferences.sublime-settings;
rm $HOME/.config/sublime-text-3/Packages/User/Default\ \(Linux\).sublime-keymap; ln -s $HOME/dotfiles/sublime-keymap.json $HOME/.config/sublime-text-3/Packages/User/Default\ \(Linux\).sublime-keymap;
rm $HOME/.config/sublime-text-3/Packages/User/LocalHistory.sublime-settings; ln -s $HOME/dotfiles/sublime-lhistory.json $HOME/.config/sublime-text-3/Packages/User/LocalHistory.sublime-settings;

echo "termite"
rm $HOME/.config/termite/config; ln -s $HOME/dotfiles/termite.sh $HOME/.config/termite/config;

echo "Xdefaults"
rm $HOME/.Xdefaults; ln -s $HOME/dotfiles/Xdefaults $HOME/.Xdefaults

echo "zshrc"
rm $HOME/.zshrc; ln -s $HOME/dotfiles/zshrc.sh $HOME/.zshrc