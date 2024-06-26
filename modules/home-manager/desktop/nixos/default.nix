{ lib, config, pkgs, flake-inputs, ... }:
let
  paperwm-develop = pkgs.gnomeExtensions.paperwm.overrideAttrs (old: {
    version = "46.11.2";

    # 2024-06-13: pin Gnome46 release. Required as part of the
    # nixpkgs 24.05 update cycle.
    src = pkgs.fetchFromGitHub {
      owner = "paperwm";
      repo = "PaperWM";
      rev = "2ab1d62eaff52c83c3c4a9bf804aa27382936beb"; # v46.11.2
      hash = "sha256-EGS6XyRqTiKiJ5EQP5O8jHK9rE2hWK1Sf7Vuw2eLcWg=";
    };
  });

in
{
  imports = [ ../../default.nix flake-inputs.flatpaks.homeManagerModules.nix-flatpak ];

  services.flatpak.packages = [
    { appId = "com.brave.Browser"; origin = "flathub";  }
    "im.riot.Riot"
    "com.logseq.Logseq"
    "com.jetbrains.IntelliJ-IDEA-Community"
    "org.signal.Signal"
    "io.typora.Typora"
    "net.ankiweb.Anki"
    "com.visualstudio.code"
  ];
  services.flatpak.uninstallUnmanaged = true;

  home.packages = with pkgs; [
    firefox
    _1password-gui
    obsidian
    spotify
    whatsapp-for-linux
    tdesktop # Telegram Desktop app
    chromium
    slack
    weechat
    hexchat
    podman
    paperwm-develop
    gnomeExtensions.appindicator
    synology-drive-client
    powertop
    gcc
    gnome.gnome-tweaks
    protonvpn-gui
    yacreader
    qbittorrent
    tor-browser-bundle-bin
    gnumake
    chiaki
    steam
    steam-run
    steam-rom-manager
    quickemu
  ];
  # Enable fractional scaling for Gnome DM.
  dconf.settings = {
    "org/gnome/mutter" = {
      experimental-features = [ "scale-monitor-framebuffer" ];
    };
  };
}
