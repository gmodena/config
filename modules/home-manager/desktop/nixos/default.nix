{ input, config, pkgs, ... }: {
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
  ];
}
