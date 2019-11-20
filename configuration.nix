# Edit this configuration file to define what should be installed on
# your system.  Help is available in the configuration.nix(5) man page
# and in the NixOS manual (accessible by running ‘nixos-help’).

{ config, pkgs, ... }:

{
  imports =
    [ # Include the results of the hardware scan.
      ./hardware-configuration.nix
    ];

  # boot
  boot.loader.grub.enable = true;
  boot.loader.grub.version = 2;
  boot.loader.grub.device = "/dev/sda"; 
  boot.loader.grub.useOSProber = true;

  # networking
  networking.hostName = "nixos";
  networking.useDHCP = false;
  networking.interfaces.enp2s0.useDHCP = true;
  networking.networkmanager.enable = true;

  # i18n
  i18n = {
    consoleFont = "Lat2-Terminus16";
    consoleKeyMap = "us";
    defaultLocale = "en_US.UTF-8";
  };

  # time
  time.timeZone = "Europe/Moscow";

  # nixpkgs
  nixpkgs.config.allowUnfree = true;

  # environment
  environment.systemPackages = with pkgs; [
    wget vim firefox termite networkmanagerapplet
  ];

  # sound
  sound.enable = true;
  hardware.pulseaudio.enable = true;


  # xserver
  services.xserver = {
    enable = true;
    layout = "us,ru";
    xkbOptions = "grp:win_space_toggle,grp_led:scroll,caps:swapescape";
    
    desktopManager.xterm.enable = false;

    displayManager.auto = {
      enable = true;
      user = "ki";
    };

    windowManager = {
      default = "i3";
      i3.enable = true;
      i3.configFile = pkgs.writeText "i3-config-file" (import ./i3.nix pkgs); 
      #i3.package = let
      #  text = import ./i3.nix pkgs;
      #  configFile = pkgs.writeText "i3-config-file" text;
      #in pkgs.writeScriptBin "i3" ''
      #  #!${pkgs.stdenv.shell}
      #  exec ${pkgs.i3} -c ${configFile}
      #'';
    };

    videoDrivers = [ "nvidia" ];
  };

  services.compton = {
    enable = true;

    backend = "xrender";
    vSync = true; 
  };

  programs.fish.enable = true;

  # users
  users = {
    mutableUsers = false;

    users.root = {
      password = "";
      shell = pkgs.fish;
    };

    users.ki = {
      isNormalUser = true;
      password = "";
      uid = 1000;
      extraGroups = [ "networkmanager" ];
      shell = pkgs.fish;
    };
  };

  # sudo
  security.sudo = {
    enable = true;
    extraRules = [{
      groups = [ "users" ];
      commands = [{
        command = "ALL";
        options = [ "NOPASSWD" ];
      }];
    }];
  };

  # system
  system.stateVersion = "19.09"; # Did you read the comment?

}

