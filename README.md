[![system build](https://github.com/gmodena/config/actions/workflows/build.yml/badge.svg)](https://github.com/gmodena/config/actions/workflows/build.yml)

This repo is a [flake](https://nixos.wiki/wiki/Flakes) that manages the configuration of
my [NixOs](https://nixos.org) and [nix-darwin](https://github.com/LnL7/nix-darwin) systems.

# Build

On darwin
```
darwin-rebuild switch --flake '.#'
```

On nixos:
```
