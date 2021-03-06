{ inputs, config, pkgs, lib, ... }:
let
    userName = "gmodena";
    homePrefix = if config.system == "x86_64-darwin" then "/Users" else "/home";
in {
  nix.package = pkgs.nixFlakes;
  nix.extraOptions = lib.optionalString (config.nix.package == pkgs.nixFlakes)
		"experimental-features = nix-command flakes";

 
  user = {
      name = "${userName}";
      shell = pkgs.zsh;
      home = "${homePrefix}/${userName}";
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
}
