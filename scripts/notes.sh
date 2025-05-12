#!/usr/bin/zsh

cd ~/Documents/notes

git add .
git commit -m "Notes Update"
git pull --rebase
git push -u origin master
