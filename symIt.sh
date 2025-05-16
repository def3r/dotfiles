# Not a forceful SymLinkin

dotfiles="$PWD"
dest="$HOME"
mkdir -p backup/

ln -s $dotfiles/.config/alacritty $dest/.config/alacritty

if [[ -d "$dest/.config/fish" ]]; then
  rm -rf backup/fish
  mv "$dest/.config/fish" backup/
  rm -rf "$dest/.config/fish"
fi
ln -s $dotfiles/.config/fish $dest/.config/fish

ln -s $dotfiles/.config/gh $dest/.config/gh
ln -s $dotfiles/.config/nvim $dest/.config/nvim
ln -s $dotfiles/.config/omf $dest/.config/omf

ln -s "$dotfiles/.bashrc" "$dest/.bashrc"
ln -s "$dotfiles/.tmux.conf" "$dest/.tmux.conf"
ln -s "$dotfiles/.vimrc" "$dest/.vimrc"
ln -s "$dotfiles/.zshrc" "$dest/.zshrc"
