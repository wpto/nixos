# Edit this configuration file to define what should be installed on
# your system.  Help is available in the configuration.nix(5) man page
# and in the NixOS manual (accessible by running ‘nixos-help’).

{ config, pkgs, ... }:
let
  ports = [
    22   # ssh
    9091 # transmission
    8080 # kodi web server
    80   # airplay
    443
    554
    3689
    5353
    9777 # event server port
    1234 # iptv
    20000
    7 
  ];

  proxyAddress = "127.0.0.1:9050";
  sshAddress  = "0.0.0.0";
  sshPort     = 22; 

in rec {
  imports =
    [ # Include the results of the hardware scan.
      ./hardware-configuration.nix
    ];

  boot.loader.systemd-boot.enable = true;
  boot.loader.efi.canTouchEfiVariables = true;


  networking.networkmanager.enable = true;
  networking.interfaces.eno1.useDHCP = true;

  #networking.firewall.enable = false;
  networking.firewall.enable = true;
  networking.firewall.allowedTCPPorts = ports;
  networking.firewall.allowedUDPPorts = ports;

  # services.transmission = {
  #  enable = true;
  #  settings = {
  #    encryption = 2;
  #    "utp-enable" = false;
  #    "peer-port-random-on-start" = true;
  #    "rpc-host-whitelist-enabled" = false;
  #    "rpc-whitelist-enabled" = false;
  #    "download-dir" = "/home/kodi";
  #    "incomplete-dir" = "/home/kodi/.transmission-incomplete";
  #    "incomplete-dir-enable" = true;
  #  };
  #  user = "kodi";
  #  home = "/home/kodi/";
  #};

  # i18n
  i18n = {
    consoleFont = "Lat2-Terminus16";
    consoleKeyMap = "us";
    defaultLocale = "en_US.UTF-8";
  };

  # time
  time.timeZone = "Europe/Moscow";

  # nixpkgs
  nixpkgs.config = {
    allowUnfree = true;
  };

  # environment
  environment.systemPackages = with pkgs; [
    wget vim firefox chromium
  ];

  # sound
  sound.enable = true;
  hardware.pulseaudio.enable = true;

  hardware.opengl = {
    driSupport32Bit = true;
    enable = true;
  };

  # xserver
  services.xserver = {
    enable = true;
    layout = "us,ru";
    xkbOptions = "grp:alt_shift_toggle,grp_led:scroll";
    # videoDrivers = [ "nvidiaLegacy390" ];
    
    desktopManager.xterm.enable = false;
    desktopManager.kodi.enable = true;

    displayManager.auto = {
      enable = true;
      user = "kodi";
    };
  };

  fonts = {
    fonts = with pkgs; [ terminus_font freefont_ttf ];
    fontconfig.defaultFonts = {
      monospace = [ "Terminus" ];
      sansSerif = [ "FreeSans" ];
      serif     = [ "FreeSerif" ];      
    };
  };

  services.compton = {
    enable = true;
    backend = "glx";
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

    users.kodi = {
      isNormalUser = true;
      password = "";
      uid = 1000;
      extraGroups = [ "wheel" "networkmanager" ];
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

  # torsocks
  services.tor = {
    enable = true;
    client.enable = true;
    client.privoxy.enable = true;
    torsocks.enable = true;
    torsocks.server = proxyAddress;
  };

  # ssh
  services.openssh = {
    enable = true;
    permitRootLogin = "without-password";
    passwordAuthentication = false;
    listenAddresses = [{
      addr = sshAddress;
      port = sshPort;
    }];
  };
}

