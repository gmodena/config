{
  description = "nix system config";

  inputs = {
    flatpaks.url = "github:gmodena/nix-flatpak/main";
    #flatpaks.url = "path:///home/gmodena/repo/nix-flatpak";
    nixpkgs.url = "github:nixos/nixpkgs/nixos-24.11";
    nixpkgs-unstable.url = "github:nixos/nixpkgs/nixpkgs-unstable";
    nixpkgs-master.url = "github:nixos/nixpkgs/master";

    darwin.url = "github:LnL7/nix-darwin";
    darwin.inputs.nixpkgs.follows = "nixpkgs";
    home-manager.url = "github:nix-community/home-manager/release-24.11";
    home-manager.inputs.nixpkgs.follows = "nixpkgs";

    nixos-hardware.url = "github:NixOS/nixos-hardware/master";
  };

  outputs = inputs@{ self, nixpkgs, darwin, home-manager, nixos-hardware, flatpaks, ... }:
    let

      mkNixosConfiguration =
        { baseModules ? [
            ./modules/configuration/nixos/default.nix
            home-manager.nixosModules.home-manager
            {
              home-manager.useGlobalPkgs = true;
              home-manager.useUserPackages = true;
              home-manager.extraSpecialArgs.flake-inputs = inputs;
            }
          ]
        , extraModules ? [ ]
        }: nixpkgs.lib.nixosSystem {
          system = "x86_64-linux";
          modules = baseModules ++ extraModules;
        };

      mkDarwinConfiguration =
        { baseModules ? [
            ./modules/configuration/darwin/default.nix
            home-manager.darwinModules.home-manager
            {
              home-manager.useUserPackages = true;
            }
          ]
        , extraModules ? [ ]
        }: darwin.lib.darwinSystem {
          system = "aarch64-darwin";
          modules = baseModules ++ extraModules;
        };

    in
    {
      nixosConfigurations = {
        framework-nixos-1 = mkNixosConfiguration {
          extraModules = [
            nixos-hardware.nixosModules.framework-12th-gen-intel
            ./modules/configuration/nixos/framework-nixos-1/default.nix
            ./profiles/personal.nix
          ];
        };
      };

      darwinConfigurations = {
        wmf3482 = mkDarwinConfiguration {
          extraModules = [ ./profiles/wmf.nix ];
        };
      };
    };
}
