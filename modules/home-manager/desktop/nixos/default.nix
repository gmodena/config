{ input, config, pkgs, ... }: {
  imports = [../../default.nix ];
  
  home.packages = with pkgs; [
    _1password-gui
    obsidian
    logseq
    spotify
  ];
}
