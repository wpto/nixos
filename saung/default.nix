{ config, pkgs, ... }:
rec {
  imports =
    [ # Include the results of the hardware scan.
      ./hardware-configuration.nix
      ./sudo.nix
      ./xserver.nix
      ./tor.nix
      ./firewall.nix
    ];

  boot.loader.systemd-boot.enable = true;
  boot.loader.efi.canTouchEfiVariables = true;

  networking.networkmanager.enable = true;
  networking.interfaces.eno1.useDHCP = true;

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
    wget vim git steam
  ];

  # sound
  sound.enable = true;
  hardware.pulseaudio.enable = true;

  # users
  users = {
    mutableUsers = false;

    users.root = {
      password = "";
      shell = pkgs.bashInteractive;
    };

    users.kodi = {
      isNormalUser = true;
      password = "";
      uid = 1000;
      extraGroups = [ "wheel" "networkmanager" ];
      shell = pkgs.bashInteractive;
    };
  };

  system.stateVersion = "19.09";
}

