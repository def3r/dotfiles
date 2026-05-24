#!/bin/sh

# symIt
# Not a forceful SymLinkin

function env_msg {
  status=$(echo ":$PATH:" | grep ":${dest}/${1}:")
  if [[ -z "$status" ]]; then
    echo "- Add ${dest}/${1} to path env"
  fi
}

function link {
  ln $flag "$dotfiles/$1" "$dest/$1"
  if [ $? -ne 0 ]; then
    return
  fi

  if [[ "$2" == "env" ]]; then
    env_msg $1
  fi
}

function init {
  mkdir -p ~/.config/
  mkdir -p backup/
}

dotfiles="$PWD"
dest="$HOME"
flag=-s

init

if [[ "$1" == "-f" ]]; then
  flag=-sf
elif [[ "$1" == "--force" ]]; then
  flag=-sf
fi

if [[ -d "$dest/.config/fish" ]]; then
  rm -rf backup/fish
  mv "$dest/.config/fish" backup/
  rm -rf "$dest/.config/fish"
fi
link .config/fish

link .config/gh
link .config/nvim
link .config/omf
link .config/waybar
link .config/kitty/kitty.conf
link .config/alacritty

# hypr
link .config/hypr/scripts
link .config/hypr/hyprland.conf
link .config/hypr/hypridle.conf
link .config/hypr/hyprlock.conf
link .config/hypr/hyprsunset.conf

link .scripts "env"

link .bashrc
link .tmux.conf
link .vimrc
link .zshrc

