{ config, pkgs, ... }:

{
  imports = [ <home-manager/nix-darwin> ];

  # List packages installed in system profile. To search by name, run:
  # $ nix-env -qaP | grep wget
  environment.systemPackages = with pkgs;
  [ adoptopenjdk-openj9-bin-8
    neovim
    tmux
    bat
    python37
  ];

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
  # programs.fish.enable = true;

  users.users.gmodena = {
    name = "gmodena";
    home = "/Users/gmodena";
  };
  home-manager.users.gmodena = { pkgs, ... }: {
    home.packages = [ pkgs.atool pkgs.httpie ];
    programs.bat.enable = true;
    programs.neovim = {
      enable = true;
      vimAlias = true;
      extraConfig = "colorscheme gruvbox";
      plugins = with pkgs.vimPlugins; [
        vim-nix
        gruvbox
      ];
    };
  };

  # Used for backwards compatibility, please read the changelog before changing.
  # $ darwin-rebuild changelog
  system.stateVersion = 4;
}
