#!/bin/bash
echo "## Setup dotfiles ##"

echo "Configuration"
echo "- i3wm"
rm $HOME/.config/i3/config; ln -s $HOME/dotfiles/i3.md $HOME/.config/i3/config;
echo "- git"
rm $HOME/.gitconfig; ln -s $HOME/dotfiles/gitconfig $HOME/.gitconfig
echo "- ipython"
rm $HOME/.ipython/profile_default/ipython_config.py; ln -s $HOME/dotfiles/ipython.py $HOME/.ipython/profile_default/ipython_config.py;
echo "- sublime"
rm $HOME/.config/sublime-text-3/Packages/User/Preferences.sublime-settings; 
ln -s $HOME/dotfiles/sublime-settings.json $HOME/.config/sublime-text-3/Packages/User/Preferences.sublime-settings;
rm $HOME/.config/sublime-text-3/Packages/User/Default\ \(Linux\).sublime-keymap; 
ln -s $HOME/dotfiles/sublime-keymap.json $HOME/.config/sublime-text-3/Packages/User/Default\ \(Linux\).sublime-keymap;
rm $HOME/.config/sublime-text-3/Packages/User/LocalHistory.sublime-settings; 
ln -s $HOME/dotfiles/sublime-lhistory.json $HOME/.config/sublime-text-3/Packages/User/LocalHistory.sublime-settings;
echo "- urxvt"
rm $HOME/.Xdefaults; ln -s $HOME/dotfiles/Xdefaults $HOME/.Xdefaults;
echo "- zshrc"
rm $HOME/.zshrc; echo "source $HOME/dotfiles/zshrc.sh" >> $HOME/.zshrc; 

echo "Scripts"
echo "- ss"
sudo ln -s $HOME/dotfiles/bash/create_ss/ss.sh /usr/bin/ss
echo "- gif"
sudo ln -s $HOME/dotfiles/bash/create_gif/gif.sh /usr/bin/gif
sudo ln -s $HOME/dotfiles/bash/create_gif/rflag.sh /usr/bin/gife
echo "- imgur"
sudo ln -s $HOME/dotfiles/bash/imgur.sh /usr/bin/imgur
echo "- dmenu search"
sudo ln -s $HOME/dotfiles/dmenu-search/dmenu_search.sh /usr/bin/dmenu_search