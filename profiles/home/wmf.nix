{ config, lib, pkgs, ... }: {
  programs.git = {
    userEmail = "gmodena@wikimedia.org";
    userName = "Gabriele Modena";
  };
}
