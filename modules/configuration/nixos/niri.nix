# Niri (scrollable-tiling Wayland compositor) + Noctalia (Quickshell desktop shell).
#
# Noctalia provides the bar, app launcher, notification daemon, lock screen and
# the wifi / bluetooth / battery / volume / brightness panels, so there is no
# need for waybar, fuzzel, mako or nm-applet here.
#
# Session keybinds and output layout are per-user, see
# modules/home-manager/desktop/nixos/niri.nix.
{
  config,
  lib,
  pkgs,
  ...
}: {
  # Registers the niri session with the display manager, pulls in
  # xdg-desktop-portal-gnome and gnome-keyring (both recommended upstream).
  programs.niri.enable = true;

  environment.systemPackages = with pkgs; [
    noctalia-shell
    xwayland-satellite # X11 clients; niri starts it on demand
    playerctl # media keys
    brightnessctl # backlight keys (also bundled with noctalia-shell)
    wl-clipboard
    libnotify # notify-send, for testing the notification daemon
  ];

  # Services the Noctalia widgets talk to over D-Bus. GNOME enables most of
  # these implicitly; declare them so the niri session stands on its own.
  services.upower.enable = true; # battery widget
  services.power-profiles-daemon.enable = true; # power profile switching
  networking.networkmanager.enable = true; # wifi (nmcli)
  hardware.bluetooth.enable = true; # bluetooth (bluetoothctl)

  # GNOME ships a polkit agent as part of gnome-shell; niri does not, and
  # without one anything that needs authentication (1Password, fwupd, mounting
  # disks) silently hangs. Scoped to niri.service so it does not double up with
  # gnome-shell's agent when logging into the GNOME session.
  systemd.user.services.polkit-gnome-authentication-agent-1 = {
    description = "polkit-gnome authentication agent";
    wantedBy = ["niri.service"];
    partOf = ["niri.service"];
    after = ["niri.service"];
    serviceConfig = {
      Type = "simple";
      ExecStart = "${pkgs.polkit_gnome}/libexec/polkit-gnome-authentication-agent-1";
      Restart = "on-failure";
      RestartSec = 1;
    };
  };

  # Noctalia draws its icons from a bundled Tabler font, but falls back to the
  # system font for everything else.
  fonts.packages = with pkgs; [
    inter
    noto-fonts
    noto-fonts-color-emoji
    nerd-fonts.jetbrains-mono
  ];
}
