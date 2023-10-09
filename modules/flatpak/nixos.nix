{ config, lib, pkgs, osConfig, ... }:
with lib;

let
  cfg = config.services.flatpak;
  installation = "system";
in
{
  options.services.flatpak = import ./default.nix { inherit cfg lib pkgs osConfig lib; };

  config = lib.mkIf osConfig.services.flatpak.enable {
    systemd.services."flatpak-managed" = {
      Unit = {
        After = [
          "network.target"
        ];
      };
      Install = {
        WantedBy = [
          "default.target"
        ];
      };
      serviceConfig = {
        Type = "oneshot";
        ExecStart = "${import ./installer.nix {inherit cfg pkgs; installation = installation; }}";
      };
    };
  }
