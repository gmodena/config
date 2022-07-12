{ config, lib, pkgs, ... }: {
  programs.git = {
    userEmail = "gmodena@wikimedia.org";
    userName = "Gabriele Modena";
  };

  xdg.configFile."barrier/barrier.conf" = {
    # Barrier KVM server configuration.
    text = builtins.readFile  ../../modules/home/barrier.conf;
  };
}
