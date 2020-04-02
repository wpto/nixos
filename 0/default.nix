{ config, pkgs, ... }:
rec {
  imports =
    [
      ./hardware-configuration.nix
      ../system/nm/wifi.nix
      #./ap.nix
      ./imports.nix
    ];

  # default.nix launch specific settings here
  boot.loader.grub.enable = true;
  boot.loader.grub.version = 2;
  boot.loader.grub.device = "/dev/sda";
  boot.loader.grub.useOSProber = true;


  networking.hostName = "pinky";
  networking.useDHCP = false;

  networking.interfaces.enp2s0.useDHCP = true;
  networking.interfaces.wlp3s0.useDHCP = true;

  networking.networkmanager.enable = true;
  networking.networkmanager.packages = [ pkgs.rpPPPoE pkgs.dnsmasq];
  networking.firewall.allowedTCPPorts = [8080];
  networking.firewall.allowedUDPPorts = [9777 1900];
  

  hardware.opengl.driSupport32Bit = true;

  system.stateVersion = "19.09";

}

