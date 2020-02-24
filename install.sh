#!/bin/bash

set -x

CURRDIR=$(pwd)

sudo pacman -S zsh
chsh -s /bin/zsh

cd ~
rm .zshrc
ln -s "${CURRDIR}/zsh_config/zshrc" .zshrc

mkdir -p .config/nvim
cd .config/nvim
rm init.vim
ln -s "${CURRDIR}/nvim_config/init.vim" init.vim

# Setup Vim PLUG
curl -fLo ~/.local/share/nvim/site/autoload/plug.vim --create-dirs \
    https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim

cd ${CURRDIR}

git config --global user.name "Ankur Sharma"
git config --global user.email "ankur.sharma@uni-saarland.de"
