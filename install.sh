#!/bin/bash

files=(vimrc bashrc astylerc inputrc toprc fzf.bash gitconfig)
fileLocation=~/dotfiles

for file in "${files[@]}"
do
	if [ -f ~/.$file ]; then
		mv ~/.$file ~/.OLD$file
	fi
	ln -s "$fileLocation/$file" ~/.$file
done


