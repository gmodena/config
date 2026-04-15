{
  description = "nix system config";

  inputs = {
    flatpaks.url = "github:gmodena/nix-flatpak/main";
    #flatpaks.url = "path:///home/gmodena/repo/nix-flatpak";
    nixpkgs.url = "github:nixos/nixpkgs/nixos-25.11";
    nixpkgs-unstable.url = "github:nixos/nixpkgs/nixpkgs-unstable";
    nixpkgs-master.url = "github:nixos/nixpkgs/master";

    darwin.url = "github:LnL7/nix-darwin/nix-darwin-25.11";
    darwin.inputs.nixpkgs.follows = "nixpkgs";
    home-manager.url = "github:nix-community/home-manager/release-25.11";
    home-manager.inputs.nixpkgs.follows = "nixpkgs";

    nvf = {
      url = "github:NotAShelf/nvf";
      # You can override the input nixpkgs to follow your system's
      # instance of nixpkgs. This is safe to do as nvf does not depend
      # on a binary cache.
      inputs.nixpkgs.follows = "nixpkgs";
    };

    nixos-hardware.url = "github:NixOS/nixos-hardware/master";
  };

  outputs = inputs@{ self, nixpkgs, darwin, home-manager, nixos-hardware, flatpaks, nvf, ... }:
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
            nvf.nixosModules.default
          ]
        , extraModules ? [ ]
        }: nixpkgs.lib.nixosSystem {
          system = "x86_64-linux";
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
        x1-nixos-1 = mkNixosConfiguration {
          extraModules = [
            nixos-hardware.nixosModules.lenovo-thinkpad-x1-11th-gen
            ./modules/configuration/nixos/x1-nixos-1/default.nix
            ./profiles/wmf.nix
          ];
        };
      };
    };
}
