#!/bin/bash

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

start="$HOME/.vim/pack/plugins/start"

mkdir -p "$start"
cd "$start"

if [[ ! -a "denops.vim" ]]
then
  git clone https://github.com/vim-denops/denops.vim denops.vim
fi

if [[ ! -a "skkeleton" ]]
then
  git clone https://github.com/vim-skk/skkeleton skkeleton
fi
