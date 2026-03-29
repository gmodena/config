{
  lib,
  config,
  pkgs,
  flake-inputs,
  ...
}: {
  imports = [../../default.nix flake-inputs.flatpaks.homeManagerModules.nix-flatpak];

  services.flatpak.packages = [
    {
      appId = "com.brave.Browser";
      origin = "flathub";
    }
    "im.riot.Riot"
    "com.logseq.Logseq"
    "com.jetbrains.IntelliJ-IDEA-Community"
    "com.jetbrains.PyCharm-Community"
    "org.signal.Signal"
    "com.visualstudio.code"
  ];
  services.flatpak.uninstallUnmanaged = true;
  services.flatpak.uninstallUnused = true;
  services.flatpak.update.auto.enable = true;
  services.flatpak.update.onActivation = false;

  services.flatpak.overrides.settings = {
    global = {
      # Force Wayland by default
      Context.sockets = ["wayland" "!x11" "fallback-x11"];

      Environment = {
        # Fix un-themed cursor in some Wayland apps
        XCURSOR_PATH = "/run/host/user-share/icons:/run/host/share/icons";

        # Force correct theme for some GTK apps
        GTK_THEME = "Adwaita:dark";

        LC_ALL = "C.UTF8";
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

  services.flatpak.overrides.pruneUnmanagedOverrides = true;
  services.flatpak.overrides.writeMode = "merge";

  home.packages = with pkgs; [
    firefox
    _1password-gui
    obsidian
    spotify
    wasistlos
    telegram-desktop # Telegram Desktop app
    chromium
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
    quickemu
    ghostty
    deskflow
    wayland-utils
    gemini-cli
    claude-code
    opencode
    aider-chat
  ];

  services.ollama.enable = true;

  # Enable fractional scaling for Gnome DM.
  dconf.settings = {
    "org/gnome/mutter" = {
      experimental-features = ["scale-monitor-framebuffer"];
    };
  };

  home.sessionPath = ["$HOME/.local/bin"];
}
