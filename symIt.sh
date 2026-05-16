# a forceful SymLinkin

dotfiles="$PWD"
dest="$HOME"
mkdir -p backup/

ln -sf $dotfiles/.config/alacritty $dest/.config/alacritty

if [[ -d "$dest/.config/fish" ]]; then
  rm -rf backup/fish
  mv "$dest/.config/fish" backup/
  rm -rf "$dest/.config/fish"
fi
ln -sf $dotfiles/.config/fish $dest/.config/fish

ln -sf $dotfiles/.config/gh   $dest/.config/gh
ln -sf $dotfiles/.config/nvim $dest/.config/nvim
ln -sf $dotfiles/.config/omf  $dest/.config/omf
ln -sf $dotfiles/.config/waybar  $dest/.config/waybar

ln -sf $dotfiles/.scripts        $dest/.scripts
echo "- Add ${dest}/.scripts to path env"

ln -sf $dotfiles/.config/hypr/scripts       $dest/.config/hypr/scripts
ln -sf $dotfiles/.config/hypr/hyprland.conf $dest/.config/hypr/hyprland.conf

ln -sf "$dotfiles/.bashrc"          "$dest/.bashrc"
ln -sf "$dotfiles/.tmux.conf"       "$dest/.tmux.conf"
ln -sf "$dotfiles/.vimrc"           "$dest/.vimrc"
ln -sf "$dotfiles/.zshrc"           "$dest/.zshrc"
ln -sf "$dotfiles/kitty/kitty.conf" "$dest/.config/kitty/kitty.conf"
