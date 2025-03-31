all:
	cd home; make all; cd -

nix:
	stow --verbose --target=/etc/nixos/ --restow nixos
	cd home; make all; cd -

delete:
	cd home; make delete; cd -

delete_nix:
	stow --verbose --target=/etc/nixos/ --delete nixos
	cd home; make delete; cd -
