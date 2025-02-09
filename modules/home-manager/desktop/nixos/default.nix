{ lib, config, pkgs, flake-inputs, ... }:
{
  imports = [ ../../default.nix flake-inputs.flatpaks.homeManagerModules.nix-flatpak ];

  services.flatpak.packages = [
    { appId = "com.brave.Browser"; origin = "flathub"; }
    "im.riot.Riot"
    "com.logseq.Logseq"
    "com.jetbrains.IntelliJ-IDEA-Community"
    "com.jetbrains.PyCharm-Community"
    "org.signal.Signal"
    "io.typora.Typora"
    "net.ankiweb.Anki"
    "com.visualstudio.code"
    "app.zen_browser.zen"
    "edu.mit.Scratch"
  ];
  services.flatpak.uninstallUnmanaged = false;
  services.flatpak.uninstallUnused = true;
  services.flatpak.update.auto.enable = true;
  services.flatpak.update.onActivation = false;

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
    gnomeExtensions.appindicator
    gnomeExtensions.caffeine
    gnomeExtensions.paperwm
    synology-drive-client
    powertop
    gcc
    gnome.gnome-tweaks
    protonvpn-gui
    yacreader
    tor-browser-bundle-bin
    gnumake
    chiaki
    steam
    steam-run
    steam-rom-manager
    quickemu
    discord
  ];
  # Enable fractional scaling for Gnome DM.
  dconf.settings = {
    "org/gnome/mutter" = {
      experimental-features = [ "scale-monitor-framebuffer" ];
    };
  };

  home.sessionPath = [ "$HOME/.local/bin" ];
  home.file = {
    "zwift.sh" = {
      source = pkgs.fetchurl {
        url = "https://raw.githubusercontent.com/netbrain/zwift/master/zwift.sh";
        hash = "sha256-iqHPcHIQ/vr+HQtRsO01aKt3T7fwW3NQnrhqhKiB/Cc=";
      };
      target = ".local/bin/zwift";
      executable = true;
    };
  };
}
