{ config, pkgs, ... }:
let
  hostName = "penti";
  ethernetInterface = "enp3s0";
  grubDevice = "/dev/sda";
in rec {
  imports = [ ./hardware-configuration.nix ../toiba/imports.nix ];

  boot.loader.grub = {
    enable = true;
    version = 2;
    device = grubDevice;
  };

  networking.hostName = hostName;
  
  networking.interfaces."${ethernetInterface}".useDHCP = true;

  system.stateVersion = "19.09";
}
