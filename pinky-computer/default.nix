{ config, pkgs, ... }:
rec {
  imports =
    [
      ./hardware-configuration.nix
      ./wifi.nix
      ./imports.nix
    ];

  # default.nix launch specific settings here
  boot.loader.grub.enable = true;
  boot.loader.grub.version = 2;
  boot.loader.grub.device = "/dev/sda";
  boot.loader.grub.useOSProber = true;


  networking.hostName = "pinky";
  networking.wireless.enable = true;
 
  networking.useDHCP = false;
  networking.interfaces.enp2s0.useDHCP = true;
  networking.interfaces.wlp3s0.useDHCP = true;
  
  hardware.opengl.driSupport32Bit = true;

  system.stateVersion = "19.09";

}

