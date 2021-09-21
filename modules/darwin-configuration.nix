{ config, pkgs, lib, ... }:
{
  nix.nixPath = [
    "nixpkgs=https://github.com/NixOS/nixpkgs/archive/refs/heads/nixpkgs-21.05-darwin.tar.gz"
    "home-manager=https://github.com/nix-community/home-manager/archive/release-21.05.tar.gz"
    "darwin=https://github.com/LnL7/nix-darwin/archive/master.tar.gz"
  ];

  nix.package = pkgs.nixFlakes;
  nix.extraOptions = lib.optionalString (config.nix.package == pkgs.nixFlakes)
		"experimental-features = nix-command flakes";

  # List packages installed in system profile. To search by name, run:
  # $ nix-env -qaP | grep wget
  environment.systemPackages = with pkgs;
  [ adoptopenjdk-openj9-bin-8
    neovim
    tmux
    bat
    python37
    neomutt
    nodejs
    git
  ];

  system.keyboard.enableKeyMapping = true;
  system.keyboard.remapCapsLockToEscape = true;

  system.defaults.loginwindow.GuestEnabled = false;
  system.defaults.dock.autohide = false;
  system.defaults.dock.orientation = "left";

  # Use a custom configuration.nix location.
  # $ darwin-rebuild switch -I darwin-config=$HOME/.config/nixpkgs/darwin/configuration.nix
  # environment.darwinConfig = "$HOME/.config/nixpkgs/darwin/configuration.nix";

  # Auto upgrade nix package and the daemon service.
  # services.nix-daemon.enable = true;
  # nix.package = pkgs.nix;
  homebrew  = {
    enable = true;
  };
  # Create /etc/bashrc that loads the nix-darwin environment.
  programs.zsh.enable = true;  # default shell on catalina
  programs.zsh.variables = {
    EDITOR = "vim";
  };
  # programs.fish.enable = true;

  # Used for backwards compatibility, please read the changelog before changing.
  # $ darwin-rebuild changelog
  system.stateVersion = 4;
}
