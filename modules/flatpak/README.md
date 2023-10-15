# flatpak

Declarative flatpak manager inspired by [declarative-flatpak](https://github.com/GermanBread/declarative-flatpak) and nix-darwin's [homebrew](https://github.com/LnL7/nix-darwin/blob/master/modules/homebrew.nix) module.
Nixos and home-manager modules are provided for system wide or user flatpak installation.

# Setup

Enable flatpak in `configuration.nix`:
```nix
services.flatpak.enable = true;
```

import the module and declare packages to install with:
```nix
  services.flatpak.packages = [
    { appId = "com.brave.Browser"; origin = "flathub";  }
    "com.obsproject.Studio"
    "im.riot.Riot"
  ];
```

Rebuild system - or home-manager - for changes to take place.