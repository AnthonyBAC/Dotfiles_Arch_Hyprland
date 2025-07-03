#!/usr/bin/zsh
cp -r ~/.config/alacritty ~/dotfiles
cp -r ~/.config/dunst ~/dotfiles
cp -r ~/.config/fastfetch ~/dotfiles
cp -r ~/.config/gtk-2.0 ~/dotfiles
cp -r ~/.config/gtk-3.0 ~/dotfiles
cp -r ~/.config/gtk-4.0 ~/dotfiles
cp -r ~/.config/hypr ~/dotfiles
cp -r ~/.config/nwg-look ~/dotfiles
cp -r ~/.config/qt6ct ~/dotfiles
cp -r ~/.config/rofi ~/dotfiles
cp -r ~/.config/wal ~/dotfiles
cp -r ~/.config/waybar ~/dotfiles
cp -f ~/.zshrc ~/dotfiles
cp -r ~/scripts ~/dotfiles
cp -r ~/Pictures/wallpapers ~/dotfiles
cp -r /usr/share/sddm ~/dotfiles
cp -r ~/.config/yazi ~/dotfiles
cp -r ~/.config/kitty ~/dotfiles
cp -r ~/.vimrc ~/dotfiles
cp -r ~/.cache/wal/sequences ~/dotfiles

cd ~/dotfiles
git add .
git commit -m "Dotfiles Update"
git pull --rebase
git push




