#!/bin/bash

# Update repository state 
sudo pacman -Syu

# Setup ZSH
sudo pacman -S zsh
chsh -s /bin/zsh

# Set up remote access
sudo pacman -S openssh
sudo systemctl enable sshd
sudo systemctl start sshd

# Start with basics
sudo pacman -S gcc clang make automake autoconf ninja cmake git neovim ruby xsel lemonade cargo

# Setup NVIDIA drivers
sudo pacman -S nvidia nvidia-utils cuda cudnn

# More stuffs
sudo pacman -S subversion
sudo pacman -S python python2 python-pip python2-pip

# Some python libraries
sudo pacman -S ipython ipython2
sudo pacman -S python-numpy python2-numpy
sudo pacman -S python-matplotlib python2-matplotlib
sudo pacman -S python-scikit-learn python2-scikit-learn
sudo pacman -S jupyter python-pandas python2-pandas 
sudo pacman -S tensorflow-cuda

sudo pip install keras neovim
sudo pip2 install keras neovim

gem install neovim

# Setup Vim PLUG
curl -fLo ~/.local/share/nvim/site/autoload/plug.vim --create-dirs \
    https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim

git config --global user.name "Ankur Sharma"
git config --global user.email "ankur.sharma@uni-saarland.de"
