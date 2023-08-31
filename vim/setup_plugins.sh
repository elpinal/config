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

if [[ ! -a "vimtex" ]]
then
  git clone https://github.com/lervag/vimtex vimtex
fi

if [[ ! -a "vim-lsp" ]]
then
  git clone https://github.com/prabirshrestha/vim-lsp vim-lsp
fi

if [[ ! -a "vim-lsp-settings" ]]
then
  git clone https://github.com/mattn/vim-lsp-settings vim-lsp-settings
fi

if [[ ! -a "fern.vim" ]]
then
  git clone https://github.com/lambdalisue/fern.vim fern.vim
fi

if [[ ! -a "fern-git-status.vim" ]]
then
  git clone https://github.com/lambdalisue/fern-git-status.vim fern-git-status.vim
fi

if [[ ! -a "vim-sandwich" ]]
then
  git clone https://github.com/machakann/vim-sandwich vim-sandwich
fi

if [[ ! -a "lexima.vim" ]]
then
  git clone https://github.com/cohama/lexima.vim lexima.vim
fi

if [[ ! -a "forester.vim" ]]
then
  git clone https://github.com/elpinal/forester.vim forester.vim
fi

if [[ ! -a "coc.nvim" ]]
then
  git clone --branch release https://github.com/neoclide/coc.nvim coc.nvim
fi

## Help

# vim -i NONE -e -s -c "helptags $start/vimtex/doc"
