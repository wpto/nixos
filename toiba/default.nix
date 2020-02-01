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

      ./programs/tor/default.nix
      ./xserver.nix
      ./i3.nix
      ./environment.nix
      ./zsh.nix
    ];

  # default.nix launch specific settings here
  boot.loader.grup.enable = true;
  boot.loader.grup.version = 2;
  boot.loader.grup.device = "/dev/sda";

  networking.hostname = "toiba";
  networking.wireless.enable = true;
 
  networking.useDHCP = false;
  networking.interfaces.enp2s0.useDHCP = true;
  networking.interfaces.wlp3s0.useDHCP = true;
  

  system.stateVersion = "19.09";

}

