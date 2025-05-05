#!/usr/bin/zsh

cd ~/Documents/Programming_Exercises

git add .
git commit -m "Ex update"
git pull --rebase
git push -u origin main
