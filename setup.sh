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

DOTFILES=$HOME/dotfiles

ln -sf $DOTFILES/.vimrc $HOME/.vimrc
ln -sf $DOTFILES/.gitconfig $HOME/.gitconfig
