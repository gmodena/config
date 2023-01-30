{
  description = "nix system config";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixos-22.11";
    nixpkgs-unstable.url = "github:nixos/nixpkgs/nixpkgs-unstable";
    nixpkgs-master.url = "github:nixos/nixpkgs/master";
    
    darwin.url = "github:LnL7/nix-darwin";
    darwin.inputs.nixpkgs.follows = "nixpkgs";
    home-manager.url = "github:nix-community/home-manager/release-22.11";
    home-manager.inputs.nixpkgs.follows = "nixpkgs";
  };

  outputs = inputs@{ self, nixpkgs, darwin, home-manager, ... }:
  let
    mkNixosConfiguration = {
      baseModules ? [
        ./modules/configuration/nixos/default.nix
          home-manager.nixosModules.home-manager {
          home-manager.useGlobalPkgs = true;
          home-manager.useUserPackages = true;
        }
      ]
      , extraModules ? [ ]
    }: nixpkgs.lib.nixosSystem {
      system = "x86_64-linux";
      modules = baseModules ++ extraModules;
    };

    mkDarwinConfiguration = {
      baseModules ? [
        ./modules/configuration/darwin/default.nix
          home-manager.darwinModules.home-manager {
          home-manager.useUserPackages = true;
        }
      ]
      , extraModules ? [ ]
    }: darwin.lib.darwinSystem {
      system = "x86_64-darwin";
      modules = baseModules ++ extraModules;
    };

  in {
    nixosConfigurations = { 
      vmware-nixos-1 = mkNixosConfiguration {
        extraModules = [ ./modules/configuration/vmware-nixos-1/default.nix ./profiles/personal.nix];
      };
    };
   darwinConfigurations = { 
      Gabrieles-MBP = mkDarwinConfiguration {
        extraModules = [ ./profiles/personal.nix ];
      };
      wmf2799 = mkDarwinConfiguration {
        extraModules = [ ./profiles/wmf.nix ];
      };
    };
  };
}
