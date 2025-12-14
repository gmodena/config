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
    wasistlos
    telegram-desktop # Telegram Desktop app
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
    gnome-tweaks
    protonvpn-gui
    yacreader
    tor-browser
    gnumake
    chiaki
    steam
    steam-run
    steam-rom-manager
    quickemu
    discord
    ghostty
  ];
  # Enable fractional scaling for Gnome DM.
  dconf.settings = {
    "org/gnome/mutter" = {
      experimental-features = [ "scale-monitor-framebuffer" ];
    };
  };

  home.sessionPath = [ "$HOME/.local/bin" ];
}
