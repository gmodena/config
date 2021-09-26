{ config, lib, pkgs, ... }: {
  user.name = "gmodena";
  hm = { imports = [ ./home/wmf.nix ]; };
}
