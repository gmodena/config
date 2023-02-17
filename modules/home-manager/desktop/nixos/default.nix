{ input, config, pkgs, ... }:
let
  paperwm-develop = pkgs.gnomeExtensions.paperwm.overrideAttrs (old: {
    version = "39";

    # 2023-03-04: latest commit in develop. Needed to install on Gnome 43.
    src = pkgs.fetchFromGitHub {
      owner = "paperwm";
      repo = "PaperWM";
      rev = "f590f8b30f0c1962e2bc18f1a39355b0a72636cb";
      hash = "sha256-ngyTsls0RYQyepfwvNJDPdlGMRC2+woFCW4RVjsaPRU=";
    };
  });
in
{
  imports = [../../default.nix ];
 
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
  ];
}
