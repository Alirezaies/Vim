#!/bin/bash

aptvim() {
    if hash apt-vim 2>/dev/null; then
        STATUS='1'
    else
        STATUS='2'
    fi
}

aptvim;

if [ $STATUS -eq 2 ]; then
    echo "apt-vim needs to be installed, trying to install apt-vim\n"
    curl -sL https://raw.githubusercontent.com/egalpin/apt-vim/master/install.sh | sh
else
    cp ./vimrc ~/.vimrc
    # mkdir -p ~/.vim/autoload
    # cp ./vim/autoload/* ~/.vim/autoload/
    cp ./vim ~/.vim
    cp ./vimpkg ~/.vimpkg
    echo "Install Complete"
fi
