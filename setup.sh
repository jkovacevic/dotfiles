#!/bin/bash
echo "## Setup dotfiles ##"
read -p "Arch or Ubuntu? [a/u]: " os
if [[ $os == "a" ]]; then
	os="arch"
elif [[ $os == "u" ]]; then
	os="ubuntu"
else
	echo "Input [a] or [u]!"
	exit -1
fi;
echo "- i3wm"
rm $HOME/.config/i3/config; ln -s $HOME/dotfiles/i3-$os.md $HOME/.config/i3/config;

echo "- ipython"
rm $HOME/.ipython/profile_default/ipython_config.py; ln -s $HOME/dotfiles/ipython.py $HOME/.ipython/profile_default/ipython_config.py;

echo "- sublime"
rm $HOME/.config/sublime-text-3/Packages/User/Preferences.sublime-settings; ln -s $HOME/dotfiles/sublime-settings.json $HOME/.config/sublime-text-3/Packages/User/Preferences.sublime-settings;
rm $HOME/.config/sublime-text-3/Packages/User/Default\ \(Linux\).sublime-keymap; ln -s $HOME/dotfiles/sublime-keymap.json $HOME/.config/sublime-text-3/Packages/User/Default\ \(Linux\).sublime-keymap;
rm $HOME/.config/sublime-text-3/Packages/User/LocalHistory.sublime-settings; ln -s $HOME/dotfiles/sublime-lhistory.json $HOME/.config/sublime-text-3/Packages/User/LocalHistory.sublime-settings;

echo "- termite"
rm $HOME/.config/termite/config; ln -s $HOME/dotfiles/termite.sh $HOME/.config/termite/config;

echo "- zshrc"
rm $HOME/.zshrc; ln -s $HOME/dotfiles/zshrc-$os.sh $HOME/.zshrc