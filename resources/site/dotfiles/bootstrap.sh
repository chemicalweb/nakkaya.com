function tangleFile(){
    URL="https://raw.github.com/nakkaya/nakkaya.com/master/resources/${1}${2}.org"
    `wget $URL`
    emacs -Q --batch \
        --eval "(progn
                  (require 'org)
                  (require 'org-exp)
                  (require 'ob)
                  (require 'ob-tangle)
                  (find-file \"${2}.org\")
                  (org-babel-tangle)
                  (kill-buffer))"
    `rm "${2}.org"`
}

function tangle(){
    rm -f ~/.xmobarrc
    rm -rf ~/.xmonad
    rm -f ~/.keynavrc
    rm -f ~/.Xresources
    tangleFile site/dotfiles/ xmonad

    rm -rf ~/.pentadactyl
    rm -f ~/.pentadactylrc
    tangleFile site/dotfiles/ pentadactyl

    rm -f ~/.tmux.conf
    rm -rf ~/.tmux-monitor-scripts/
    tangleFile posts/ 2014-01-05-tmux-configuration

    rm -f ~/.bashrc
    rm -f ~/.profile
    tangleFile site/dotfiles/ bash

    mkdir -p ~/annex
    mkdir -p ~/source
    tangleFile posts/ 2013-10-23-notes-on-synchronization-and-backup-of-home-using-git-git-annex-and-mr
}

tangle

chmod +x ~/.bin/*
chmod +x ~/.tmux-monitor-scripts/*

rm -f ~/.emacs
echo "(load-file \"~/source/emacs/init.el\")" > ~/.emacs

#sudo apt-get update;sudo apt-get upgrade;sudo apt-get install emacs24 xmonad trayer vlc cmus git bash-completion feh rxvt-unicode-256color offlineimap gnupg lm-sensors build-essential ubuntu-restricted-extras vilistextum graphviz openjdk-6-jdk keynav tmux sysstat xsel python-pip;sudo pip install hy;sudo pip install sh

#wget -qO- http://127.0.0.1:8000/bootstrap.sh | bash
#wget -qO- https://raw.github.com/nakkaya/nakkaya.com/master/resources/site/dotfiles/bootstrap.sh | bash
