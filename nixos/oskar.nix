# Edit this configuration file to define what should be installed on
# your system.  Help is available in the configuration.nix(5) man page
# and in the NixOS manual (accessible by running ‘nixos-help’).

{ config, pkgs, ... }:

{
  # Allow unfree packages
  nixpkgs.config.allowUnfree = true;
  nixpkgs.config.allowBroken = true;

  fonts.packages = with pkgs; [ nerdfonts ];

  services.xserver = {
    enable = true;
    xkb.layout = "us,se";
    xkb.variant = "";
    xkb.options = "ctrl:nocaps,grp:lctrl_lshift_toggle";
    desktopManager = { xterm.enable = false; };

    windowManager.i3 = {
      enable = true;
      extraPackages = with pkgs; [ dmenu i3status-rust i3blocks ];
    };
  };

  services.displayManager.defaultSession = "none+i3";

  programs = {
    firefox = {
      enable = true;
      nativeMessagingHosts.packages =
        [ pkgs.plasma5Packages.plasma-browser-integration ];
    };
    direnv = {
      enable = true;
      silent = false;
      loadInNixShell = true;
      nix-direnv = {
        enable = true;
        package = pkgs.nix-direnv;
      };
    };
  };

  # List packages installed in system profile. To search, run:
  # $ nix search wget
  environment.systemPackages = with pkgs; [
    alacritty
    clang
    clang-tools
    cura # 3d printer
    fd
    feh
    man-pages
    man-pages-posix
    font-awesome
    chromium
    fzf
    git
    gnumake
    go
    luajitPackages.luarocks
    lua-language-server
    neovim # Do not forget to add an editor to edit configuration.nix! The Nano editor is also installed by default.
    powerline-go
    python3
    python311Packages.pip
    python311Packages.pynvim
    python311Packages.venvShellHook
    ripgrep
    rustup
    stow
    tig
    tmux
    unzip
    wget
    xclip
  ];
  environment.variables.EDITOR = "nvim";
}

