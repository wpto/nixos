# Edit this configuration file to define what should be installed on
# your system.  Help is available in the configuration.nix(5) man page
# and in the NixOS manual (accessible by running ‘nixos-help’).

{ config, pkgs, ... }:
rec {
  imports =
    [ # Include the results of the hardware scan.
    
      # (./. + builtins.toPath "/hardware/${systemName}/configuration.nix")
      #./programs/sxhkd/default.nix
      #./hardware/1/configuration.nix
      ./device.nix
      ./programs/tor/default.nix
      ./xserver.nix
      ./i3.nix
      ./environment.nix
      ./zsh.nix
    ];

  # fixme ~^=O=^~
  networking.firewall.enable = true;
  networking.firewall.allowedTCPPorts = [ 8001 8999 ];
  networking.firewall.allowedTCPPortRanges = [
    { from = 6881; to = 6889; }
  ];

  # i18n
  i18n = {
    consoleFont = "Lat2-Terminus16";
    consoleKeyMap = "us";
    defaultLocale = "en_US.UTF-8";
  };

  # time
  time.timeZone = "Europe/Moscow";

  # sound
  sound.enable = true;
  hardware.pulseaudio.enable = true;
  hardware.pulseaudio.daemon.config = {
    resample-method = "src-sinc-best-quality";
    default-sample-format = "float32le";
  };

  fonts = {
    fonts = with pkgs; [
      freefont_ttf
      liberation_ttf
      noto-fonts-emoji
      source-han-sans-japanese
      source-han-serif-japanese
    ];

    fontconfig.enable = true;
    fontconfig.allowBitmaps = false;
    fontconfig.defaultFonts.sansSerif = [ "FreeSans" "Source Han Sans JP" ];
    fontconfig.defaultFonts.serif     = [ "FreeSerif" "Source Han Serif JP" ];
    fontconfig.defaultFonts.monospace = [ "Liberation Mono"];
    fontconfig.defaultFonts.emoji     = [ "Noto Color Emoji" ];
    enableDefaultFonts = false;
  };

  services.compton = {
    enable = true;
    backend = "glx";
    vSync = true; 
  };

  #programs.fish.enable = true;

  # users
  users = {
    mutableUsers = false;
    defaultUserShell = pkgs.zsh;
  };
  
  users.extraUsers.root = {
    password = "";
  # useDefaultShell = true;
  };

  users.extraUsers.ki = {
    isNormalUser = true;
    password = "";
    uid = 1000;
    extraGroups = [];
    useDefaultShell = true;
  };

  # sudo
  security.sudo = {
    enable = true;
    extraRules = [{
      groups = [ "users" ];
      commands = [{ command = "ALL"; options = [ "NOPASSWD" ]; }];
    }];
  };

  # system
  system.stateVersion = "19.09"; # Did you read the comment?

}

