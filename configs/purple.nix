{ config, pkgs, ... } :
{
  # boot
  boot.loader.systemd-boot.enable = true;

  # networking
  networking.hostName = "purple";

  # filesystem
  fileSystems = {
    "/boot" = {
      device = "/dev/disk/by-label/boot";
      
    };
  };
}
