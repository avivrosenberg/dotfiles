#!/bin/bash

cd ~/.dotfiles
for file in *
do
	if [[ $file != ${0##*/} ]] #skip this script
	then
		#echo "rm -rf ~/.$file"
		#echo "ln -sfn $file ~/.$file"
		rm -rf ~/.$file
		ln -sfn .dotfiles/$file ~/.$file
	fi
done
