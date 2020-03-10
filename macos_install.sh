#!/bin/bash

brew install golang
brew install nvim
brew install tmux
brew cask install iterm2
brew cask install firefox
brew cask install spotify

cd ~
mkdir -r dev/golang/

/bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install.sh)"
python3 -m pip install --user --upgrade pynvim
brew install reattach-to-user-namespace

