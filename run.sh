#!/bin/bash

files=(vimrc bashrc astylerc inputrc toprc)
fileLocation=~/dotfiles

for file in "${files[@]}"
do
	if [ -f ~/.$file ]; then
		mv ~/.$file ~/.OLD$file
	fi
	ln -s "$fileLocation/$file" ~/.$file
done


