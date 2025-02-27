{ inputs, config, pkgs, lib, ... }:
let
    userName = "gmodena";
    homePrefix = if pkgs.system == "aarch64-darwin" then "/Users" else "/home";
in {
  nix.package = pkgs.nixVersions.stable;
  nix.extraOptions = lib.optionalString (config.nix.package == pkgs.nixVersions.stable)
		"experimental-features = nix-command flakes";

  nixpkgs.config.allowUnfree = true;
  nixpkgs.config.permittedInsecurePackages = [
    "electron-18.1.0"
    "electron-19.0.7"
    "electron-25.9.0"
  ];
  user = {
      name = "${userName}";
      shell = pkgs.zsh;
      home = "${homePrefix}/${userName}";
  };
  #hm = import ../home-manager/desktop/nixos/default.nix;
  programs.zsh.enable = true;

  # List packages installed in system profile. To search by name, run:
  # $ nix-env -qaP | grep wget
  environment.systemPackages = with pkgs;
  [ direnv
    neovim
    tmux
    bat
    python3
    nodejs
    git
    htop
  ];
}
