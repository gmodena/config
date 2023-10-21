{ lib, config, pkgs, flake-inputs, ... }:
let
  paperwm-develop = pkgs.gnomeExtensions.paperwm.overrideAttrs (old: {
    version = "39";

    # 2023-03-04: latest commit in develop. Needed to install on Gnome 43.
    src = pkgs.fetchFromGitHub {
      owner = "paperwm";
      repo = "PaperWM";
      rev = "ff4b0b66827f62b1b6824186f0e6d650de55dc24";
      hash = "sha256-QTeUbhqHi1fMhw5cgT5S6JGgDaPhBuMwn4nRcp7mSMU=";
    };
  });

in
{
  imports = [ ../../default.nix flake-inputs.flatpaks.homeManagerModules.nix-flatpak ];

  services.flatpak.packages = [
    { appId = "com.brave.Browser"; origin = "flathub";  }
    "im.riot.Riot"
  ];

  home.packages = with pkgs; [
    firefox
    _1password-gui
    obsidian
    logseq
    spotify
    whatsapp-for-linux
    tdesktop # Telegram Desktop app
    chromium
    slack
    signal-desktop
    weechat
    hexchat
    podman
    paperwm-develop
    gnomeExtensions.appindicator
    synology-drive-client
    powertop
    albert
    jetbrains.idea-community
    vscode-fhs # TODO(2023-02-04): reconsider using fhs if I stick to this IDE
    gcc
    gnome.gnome-tweaks
    protonvpn-gui
    yacreader
    qbittorrent
    tor-browser-bundle-bin
    gnumake
  ];
}
