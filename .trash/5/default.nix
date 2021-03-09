{ config, pkgs, ... }:
rec {
  imports =
    [ # Include the results of the hardware scan.
    
      # (./. + builtins.toPath "/hardware/${systemName}/configuration.nix")
      #./programs/sxhkd/default.nix
      #./hardware/1/configuration.nix
      ./hardware-configuration.nix
      ../toiba/imports.nix
    ];

  # default.nix launch specific settings here

  boot.loader.systemd-boot.enable = true;
  boot.loader.efi.canTouchEfiVariables = true; 

  networking.useDHCP = false;
  networking.interfaces.eno1.useDHCP = true;

  system.stateVersion = "19.09";

}

