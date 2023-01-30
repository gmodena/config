# Edit this configuration file to define what should be installed on
# your system.  Help is available in the configuration.nix(5) man page
# and in the NixOS manual (accessible by running ‘nixos-help’).

{ config, pkgs, ... }:

{
  imports =
    [ 
      ../nixos/default.nix
      ../../../hardware/vmware-fusion-x86_64.nix
    ];

  # Use the systemd-boot EFI boot loader.
  boot.loader.systemd-boot.enable = true;
  boot.loader.efi.canTouchEfiVariables = true;

  networking.hostName = "vmware-nixos-1"; # Define your hostname.
  networking.wireless.enable = false;  # Enables wireless support via wpa_supplicant.

}

