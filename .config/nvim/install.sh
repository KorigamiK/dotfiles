#!/usr/bin/sh

MY_NVIM=~/.config/my-nvim
export MY_NVIM

rm -rf $MY_NVIM

mkdir -p $MY_NVIM/share
mkdir -p $MY_NVIM/nvim

stow --restow --target=$MY_NVIM/nvim .

alias mnvim='XDG_DATA_HOME=$MY_NVIM/share XDG_CONFIG_HOME=$MY_NVIM nvim' 

export mnvim
