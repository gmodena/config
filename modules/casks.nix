{ config, lib, pkgs, ... }: {
  homebrew = {
    casks = [
      "1password"
      "firefox" 
      "keybase"
      "cryptomator"
      "obsidian"
      "barrier"
    ];
  };
}
