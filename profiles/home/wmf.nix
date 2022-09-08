{ config, lib, pkgs, ... }: {
  home = { 
    packages  = with pkgs; [
    minikube
    kubernetes-helm
    ];
  };
  programs.git = {
    userEmail = "gmodena@wikimedia.org";
    userName = "Gabriele Modena";
    iniContent.core = {
      sshCommand = "ssh -v";
    };
  };

  xdg.configFile."barrier/barrier.conf" = {
    # Barrier KVM server configuration.
    text = builtins.readFile  ../../modules/home/barrier.conf;
  };
}
