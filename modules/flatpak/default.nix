{ cfg, lib, pkgs, osConfig, ... }:
with lib;

let
  cfg = config.services.flatpak;

  remoteOptions = { cfg, ... }: {
    options = {
      name = mkOption {
        type = types.str;
        description = lib.mdDoc "The remote name";
        default = "flathub";
      };
      location = mkOption {
        type = types.str;
        description = lib.mdDoc "The remote location";
        default = "https://dl.flathub.org/repo/flathub.flatpakrepo";
      };
      args = mkOption {
        type = types.nullOr types.str;
        description = "Extra arguments to pass to flatpak remote-add";
        default = null;
      };
    };
  };

  packageOptions = { cfg, ... }: {
    options = {
      appId = mkOption {
        type = types.str;
        description = lib.mdDoc "The fully qualified id of the app to install.";
      };

      commit = mkOption {
        type = types.nullOr types.str;
        description = lib.mdDoc "Hash id of the app commit to install";
        default = null;
      };

      origin = mkOption {
        type = types.str;
        default = "flathub";
        description = lib.mdDoc "App repository origin (default: flathub)";
      };
    };
  };


in
{
    packages = mkOption {
      type = with types; listOf (coercedTo str (appId: { inherit appId; }) (submodule packageOptions));
      default = [ ];
      description = mkDoc ''
        Declares a list of applications to install.
      '';
    };
    remotes = mkOption {
      type = with types; listOf (coercedTo str (name: { inherit name location; }) (submodule remoteOptions));
      default = [{ name = "flathub"; location = "https://dl.flathub.org/repo/flathub.flatpakrepo"; }];
      description = mkDoc ''
        Declare a list of flatpak repositories.
      '';
    };

}
