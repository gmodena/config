{ config, pkgs, ... }:
{
  imports = [ <home-manager/nix-darwin> ];
  
  nix.nixPath = [
    "nixpkgs=https://github.com/NixOS/nixpkgs/archive/refs/heads/nixpkgs-21.05-darwin.tar.gz"
    "home-manager=https://github.com/nix-community/home-manager/archive/release-21.05.tar.gz"
    "darwin=https://github.com/LnL7/nix-darwin/archive/master.tar.gz"
  ];

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
  # programs.fish.enable = true;

  users.users.gmodena = {
    name = "gmodena";
    home = "/Users/gmodena";
  };
  home-manager.users.gmodena = { pkgs, ... }: {
    home.packages = let
      LS_COLORS = pkgs.fetchgit {
        url = "https://github.com/trapd00r/LS_COLORS";
       rev = "6fb72eecdcb533637f5a04ac635aa666b736cf50";
        sha256 = "0czqgizxq7ckmqw9xbjik7i1dfwgc1ci8fvp1fsddb35qrqi857a";
      };
      ls-colors = pkgs.runCommand "ls-colors" { } ''
        mkdir -p $out/bin $out/share
        ln -s ${pkgs.coreutils}/bin/ls $out/bin/ls
        ln -s ${pkgs.coreutils}/bin/dircolors $out/bin/dircolors
        cp ${LS_COLORS}/LS_COLORS $out/share/LS_COLORS
        '';
    in with pkgs; [ cargo ls-colors ];
    programs.bat.enable = true;
    programs.neovim = {
      enable = true;
      vimAlias = true;
      extraConfig = "colorscheme gruvbox";
      withPython3 = true;
      plugins = with pkgs.vimPlugins; [
        coc-nvim
        coc-python
        vim-nix
        gruvbox
      ];
      extraPackages = with pkgs; [
        (python3.withPackages (ps: with ps; [
          black
          flake8
        ]))
      ];
      extraPython3Packages = (ps: with ps; [
        jedi
      ]);
    };
    xdg.configFile."nvim/coc-settings.json".text = builtins.readFile /Users/gmodena/nvim/my-coc-settings.json;
  };

  # Used for backwards compatibility, please read the changelog before changing.
  # $ darwin-rebuild changelog
  system.stateVersion = 4;
}
