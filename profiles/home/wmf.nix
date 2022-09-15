{ config, lib, pkgs, ... }: {
  home = { 
    packages  = with pkgs; [
    minikube
    kubernetes-helm
    kcat
    ];
  };
  programs.git = {
    userEmail = "gmodena@wikimedia.org";
    userName = "Gabriele Modena";
    iniContent.core = {
      sshCommand = "ssh -v";
    };
  };
  programs.zsh = {
    initExtra = ''
      blubber() {
        if [ $# -lt 2 ]; then
          echo 'Usage: blubber config.yaml variant'
          return 1
        fi
        curl -s -H 'content-type: application/yaml' --data-binary @"$1" https://blubberoid.wikimedia.org/v1/"$2"
      }
    '';
  };

  xdg.configFile."barrier/barrier.conf" = {
    # Barrier KVM server configuration.
    text = builtins.readFile  ../../modules/home/barrier.conf;
  };
}
