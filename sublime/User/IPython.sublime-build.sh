pkill -f "urxvt -hold -title IPython";
urxvt -hold -title "IPython" -e /usr/bin/zsh -c "source /home/jk/ipython/venv/bin/activate && ipython -i $1";