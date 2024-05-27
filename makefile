all:
	stow --verbose --target=/etc/nixos/ --restow nixos
	cd home; make all; cd -

delete:
	stow --verbose --target=/etc/nixos/ --delete nixos
	cd home; make delete; cd -
