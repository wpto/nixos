{ config, pkgs, lib, ... } :
{
  # boot
  boot.loader.grub = {
    enable = true;
    version = 2;
    device = "/dev/sda";
    useOSProber = true;
  };

  # hardware
  imports = [ <nixpkgs/nixos/modules/installer/scan/not-detected.nix> ];
  
  boot.initrd.availableKernelModules = [ "ahci" "ohci_pci" "ehci_pci" "pata_atiixp" "usb_storage" "usbhid" "sd_mod" "sr_mod" ];
  boot.initrd.kernelModules = [];
  boot.kernelModules = [ "kvm-amd" ];
  boot.extraModulePackages = [];

  # networking
  networking.hostName = "green";

  # xserver
  services.xserver.videoDrivers = [ "nvidia" ];

  # filesystem
  fileSystems = {
    "/" = {
      device = "/dev/disk/by-label/nixos";
      fsType = "btrfs";
    };
  };

  # specific
  nix.maxJobs = lib.mkDefault 6;
}
