{ inputs, config, pkgs, lib, ... }:
{
  nix.package = pkgs.nixFlakes;
  nix.extraOptions = lib.optionalString (config.nix.package == pkgs.nixFlakes)
		"experimental-features = nix-command flakes";

  imports = [../primary.nix ../casks.nix ];

  user = { 
    name = "gmodena";
    home = "/Users/gmodena";
    shell = pkgs.zsh;
  };
  hm = import ../home.nix;

  # List packages installed in system profile. To search by name, run:
  # $ nix-env -qaP | grep wget
  environment.systemPackages = with pkgs;
  [ adoptopenjdk-openj9-bin-8
    direnv
    neovim
    tmux
    bat
    python38
    neomutt
    nodejs
    git
  ];

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
  homebrew  = {
    enable = false;
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
