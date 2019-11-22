{ config, pkgs, ... } :
{
  # boot
  boot.loader.grub = {
    enable = true;
    version = 2;
    device = "/dev/sda";
    useOSProber = true;
  };

  # networking
  networking.hostName = "green";

  # xserver
  services.xserver.videoDrivers = [ "nvidia" ];

  # filesystem
  fileSystems = {
    "/home" = {
      device = "/dev/disk/by-label/home";
      fsType = "ext4";
    };
  };
}
