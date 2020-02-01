{ config, pkgs, ... }:
rec {
  imports =
    [ # Include the results of the hardware scan.
    
      # (./. + builtins.toPath "/hardware/${systemName}/configuration.nix")
      #./programs/sxhkd/default.nix
      #./hardware/1/configuration.nix
      ./hardware-configuration.nix
      ./wifi.nix
      ./nginx-file-server.nix

      ./users.nix
      ./other.nix

      ./programs/tor/default.nix
      ./xserver.nix
      ./i3.nix
      ./environment.nix
      ./zsh.nix
    ];

  # default.nix launch specific settings here
  boot.loader.grub.enable = true;
  boot.loader.grub.version = 2;
  boot.loader.grub.device = "/dev/sda";

  networking.hostName = "nn";
  networking.wireless.enable = true;
 
  networking.useDHCP = false;
  networking.interfaces.enp2s0.useDHCP = true;
  networking.interfaces.wlp3s0.useDHCP = true;
  

  system.stateVersion = "19.09";

}

