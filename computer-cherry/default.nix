{ config, pkgs, lib, ... }:
rec {
  imports = [ 
    ./hardware-configuration.nix
    ../toiba/imports.nix
  ];

  boot.loader.grub.enable = true;
  boot.loader.grub.version = 2;
  boot.loader.grub.device = "/dev/sdb";
  boot.loader.grub.useOSProber = true; 

  networking.useDHCP = false;
  networking.interfaces.enp2s0.useDHCP = true;
  networking.hostName = lib.mkForce "cherry";

  system.stateVersion = "19.09";

  services.xserver.videoDrivers = lib.mkForce [ "nvidia" ];
}

