This repo is [flake](https://nixos.wiki/wiki/Flakes) that manages the configuration of
my [nix-darwin](https://github.com/LnL7/nix-darwin) systems.

# Build

```
darwin-rebuild switch --flake '.#' --impure
```
