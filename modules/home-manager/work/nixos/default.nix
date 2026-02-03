{ lib, config, pkgs, flake-inputs, ... }:
{
  imports = [ ../../default.nix flake-inputs.flatpaks.homeManagerModules.nix-flatpak ];

  services.flatpak.packages = [
    { appId = "com.brave.Browser"; origin = "flathub"; }
    "im.riot.Riot"
    "com.logseq.Logseq"
    "com.github.wwmm.easyeffects" # nixpkgs package is borked in 25.11
    "com.jetbrains.IntelliJ-IDEA-Ultimate"
    "com.jetbrains.PhpStorm"
  ];
  services.flatpak.uninstallUnmanaged = false;
  services.flatpak.uninstallUnused = true;
  services.flatpak.update.auto.enable = true;
  services.flatpak.update.onActivation = false;



  home.packages = with pkgs; [
    firefox-bin
    _1password-gui
    telegram-desktop # Telegram Desktop app
    chromium
    slack
    gnomeExtensions.appindicator
    gnomeExtensions.caffeine
    gnomeExtensions.paperwm
    powertop
    gnome-tweaks
    ghostty
    deskflow
    halloy
  ];

  programs.firefox.policies = {
    AutofillAddressEnabled = false;
    AutofillCreditCardEnabled = false;
    DisableFirefoxStudies = true;
    DisableFirefoxAccounts = true;
    DisableFirefoxSuggest = true;
    DisableFormHistory = false;
    DisablePocket = true;
    DisableTelemetry = true;
    DontCheckDefaultBrowser = true;
    DNSOverHTTPS = {
      Enabled = true;
      ProviderURL = "https://doh.gmodena.systems/dns-query";
      Locked = true;
      Fallback = false;
    };
    Homepage = {
      URL = "chrome://browser/content/blanktab.html";
      StartPage = "previous-session";
    };
    HttpsOnlyMode = "enabled";

    NewTabPage = false;
    OfferToSaveLogins = true;
    OverrideFirstRunPage = "";
    PictureInPicture = {
      Enabled = false;
      Locked = true;
    };
    SearchBar = "unified";
    ShowHomeButton = false;
    TranslateEnabled = false;

    # Ref: https://discourse.nixos.org/t/declare-firefox-extensions-and-settings/36265/17
    # To add additional extensions, use one of these methods
    # 1. Download add-on manually and view about:debugging#/runtime/this-firefox
    # 2. Check about:support
    # 3. find it on addons.mozilla.org, find
    #   the short ID in the url (like https://addons.mozilla.org/en-US/firefox/addon/!SHORT_ID!/)
    #   Then, download the XPI by filling it in to the install_url template, unzip it,
    #   run `jq .browser_specific_settings.gecko.id manifest.json` or
    #   `jq .applications.gecko.id manifest.json` to get the UUID

    ExtensionSettings =
      let
        extension = shortId: uuid: {
          name = uuid;
          value = {
            install_url = "https://addons.mozilla.org/en-US/firefox/downloads/latest/${shortId}/latest.xpi";
            installation_mode = "normal_installed";
          };
        };
      in
      builtins.listToAttrs [
        (extension "ublock-origin" "uBlock0@raymondhill.net")
     #   (extension "libredirect" "7esoorv3@alefvanoon.anonaddy.me")
     #   (extension "istilldontcareaboutcookies" "idcac-pub@guus.ninja")
     #   (extension "keepassxc-browser" "keepassxc-browser@keepassxc.org")
     #   (extension "popupoff" "{154cddeb-4c8b-4627-a478-c7e5b427ffdf}")
      ];
  };

  # Enable fractional scaling for Gnome DM.
  dconf.settings = {
    "org/gnome/mutter" = {
      experimental-features = [ "scale-monitor-framebuffer" ];
    };
  };

  home.sessionPath = [ "$HOME/.local/bin" ];
}
