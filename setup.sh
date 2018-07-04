#!/bin/sh
# -----------------------------------------
# Install tools
# -----------------------------------------

### Install latest vim

### Install tig

### Install ruby

# -----------------------------------------
# Set up dotfiles
# -----------------------------------------

DOTFILES=`pwd`

ln -sf $DOTFILES/.vimrc $HOME/.vimrc
ln -sf $DOTFILES/.gitconfig $HOME/.gitconfig
