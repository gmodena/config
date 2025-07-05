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
  ];
  services.flatpak.uninstallUnmanaged = false;
  services.flatpak.uninstallUnused = false;
  services.flatpak.update.auto.enable = true;
  services.flatpak.update.onActivation = false;

  services.flatpak.overrides.settings =  {
    global = {
      # Force Wayland by default
      Context.sockets = ["wayland" "!x11" "!fallback-x11"];

      Environment = {
        # Fix un-themed cursor in some Wayland apps
        XCURSOR_PATH = "/run/host/user-share/icons:/run/host/share/icons";

        # Force correct theme for some GTK apps
        GTK_THEME = "Adwaita:dark";
      };
    };

    "com.visualstudio.code".Context = {
      filesystems = [
        "xdg-config/git:ro" # Expose user Git config
        "/run/current-system/sw/bin:ro" # Expose NixOS managed software
      ];
      sockets = [
        "gpg-agent" # Expose GPG agent
        "pcsc" # Expose smart cards (i.e. YubiKey)
      ];
    };
  };

  services.flatpak.overrides.files = [ 
    "/home/gmodena/config/modules/home-manager/desktop/nixos/overrides/org.onlyoffice.desktopeditors"
    "/home/gmodena/config/modules/home-manager/desktop/nixos/overrides/org.gnome.gedit"
    "/home/gmodena/config/modules/home-manager/desktop/nixos/overrides/global"
  ];

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
    gnome-tweaks
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
    ghostty
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
        hash = "sha256-+iD3Af/23siXAYXjwFnElHeUbC+SEJ+ag2I660kIpfI=";
      };
      target = ".local/bin/zwift";
      executable = true;
    };
  };
}
