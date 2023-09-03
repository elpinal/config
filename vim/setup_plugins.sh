#!/bin/bash

[ "$DEBUG" == 'true' ] && set -x

set -eo pipefail

## SKK setup

if [[ ! -a "$HOME/.skk" ]]
then
  mkdir "$HOME/.skk"
  cd "$HOME/.skk"
  curl https://skk-dev.github.io/dict/SKK-JISYO.L.gz --output SKK-JISYO.L.gz
  gunzip SKK-JISYO.L.gz
fi

## Plugins

if [[ ! -a "$HOME/.vim/pack/jetpack/opt/vim-jetpack" ]]
then
  curl -fLo ~/.vim/pack/jetpack/opt/vim-jetpack/plugin/jetpack.vim --create-dirs https://raw.githubusercontent.com/tani/vim-jetpack/master/plugin/jetpack.vim
fi
