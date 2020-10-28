pkill -f "urxvt -hold -title IPython";
urxvt -hold -title "IPython" -e /usr/bin/zsh -c "source ~/ipython/venv/bin/activate && ipython -i $1";