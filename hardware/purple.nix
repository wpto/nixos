{ config, pkgs, lib, ... } :
{
  # boot
  boot.loader.systemd-boot.enable = true;

  boot.initrd.availableKernelModules = [ "ata_piix" "ohci_pci" "sd_mod" "sr_mod" ];
  boot.initrd.kernelModules = [];
  boot.kernelModules = [];
  boot.extraModulePackages = [];

  # networking
  networking.hostName = "purple";

  # filesystem
  fileSystems = {
    "/boot" = {
      device = "/dev/disk/by-label/boot";
      
    };
  };

  # specific
  nix.maxJobs = lib.mkDefault 1;
  virtualisation.virtualbox.guest.enable = true;
}
