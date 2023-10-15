{ config, lib, pkgs, osConfig, ... }:
with lib;

let
  cfg = config.services.flatpak;
  installation = "user";
in
{

  options.services.flatpak = import ./default.nix { inherit cfg lib pkgs osConfig; };

  config = lib.mkIf osConfig.services.flatpak.enable {
    systemd.user.services."flatpak-managed" = {
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
      Service = {
        Type = "oneshot";
        ExecStart = "${import ./installer.nix {inherit cfg pkgs; installation = installation; }}";
      };
    };
    home.activation = {
      start-service = lib.hm.dag.entryAfter [ "writeBoundary" ] ''
        export PATH=${lib.makeBinPath (with pkgs; [ systemd ])}:$PATH

        $DRY_RUN_CMD systemctl is-system-running -q && \
          systemctl --user start flatpak-managed.service || true
      '';
    };

    xdg.enable = true;
  };

}
