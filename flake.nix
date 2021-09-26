{
  description = "nix system config";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixpkgs-21.05-darwin";
    nixpkgs-unstable.url = "github:nixos/nixpkgs/nixpkgs-unstable";
    nixpkgs-master.url = "github:nixos/nixpkgs/master";
    
    darwin.url = "github:LnL7/nix-darwin";
    darwin.inputs.nixpkgs.follows = "nixpkgs";
    home-manager.url = "github:nix-community/home-manager/release-21.05";
    home-manager.inputs.nixpkgs.follows = "nixpkgs";
  };

 outputs = inputs@{ self, nixpkgs, darwin, home-manager, ... }: {
   darwinConfigurations.Gabrieles-MBP = darwin.lib.darwinSystem {
      system = "x86_64-darwin";
      modules = [ 
        ./modules/darwin-configuration.nix
        home-manager.darwinModules.home-manager {
          home-manager.useUserPackages = true; 
#          home-manager.users.gmodena = import ./modules/home.nix;
       }
       ./profiles/personal.nix
       ];
      };
    };
}
