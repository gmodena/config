{ inputs, config, pkgs, lib, ... }:
{
  imports = [ ../../primary.nix ../common.nix ../../casks.nix ];

  hm = import ../../home-manager/default.nix;

  system.keyboard.enableKeyMapping = true;
  system.keyboard.remapCapsLockToEscape = true;

  system.defaults.loginwindow.GuestEnabled = false;
  system.defaults.dock.autohide = false;
  system.defaults.dock.orientation = "left";

  # Whether to automatically rearrange spaces based on most recent use.
  # Switched off because it confuses Amethyst.
  system.defaults.dock.mru-spaces = false;

  # Use a custom configuration.nix location.
  # $ darwin-rebuild switch -I darwin-config=$HOME/.config/nixpkgs/darwin/configuration.nix
  # environment.darwinConfig = "$HOME/.config/nixpkgs/darwin/configuration.nix";

  # Auto upgrade nix package and the daemon service.
  # services.nix-daemon.enable = true;
  # nix.package = pkgs.nix;
  homebrew = {
    enable = false;
  };

  programs.zsh.enable = true;
  programs.zsh.variables = {
    EDITOR = "vim";
  };
  services.nix-daemon.enable = true;

  # Used for backwards compatibility, please read the changelog before changing.
  # $ darwin-rebuild changelog
  system.stateVersion = 4;
}
