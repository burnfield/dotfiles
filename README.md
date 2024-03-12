Utilizing [GNU stow](https://www.gnu.org/software/stow/) to symlink the dotfiles into the home folder. 

Run `make` to create-symlinks, it uses restow to ensure no additional clutter of symlinks.

To remove the symlink run `make delete`. 

To only apply one symlink run `stow --taget=$$HOME FOLDER` where `FOLDER` contains the symlinks you want.
