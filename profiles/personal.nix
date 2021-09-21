{ config, lib, pkgs, ... }: {
  user.name = "gmodena";
  user.home = "/Users/gmodena";
  imports = [ ./home/personal.nix ];
}
