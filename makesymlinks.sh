#!/bin/bash

cd ~/.dotfiles
for file in *
do
	if [[ $file != ${0##*/} ]] #skip this script
	then
		rm -rf ~/.$file # remove old link from ~/
		ln -sfn .dotfiles/$file ~/.$file # add new link to ~/
	fi
done
