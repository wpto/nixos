# Edit this configuration file to define what should be installed on
# your system.  Help is available in the configuration.nix(5) man page
# and in the NixOS manual (accessible by running ‘nixos-help’).

{ config, pkgs, ... }:
let
  systemName = import ./system-name.nix;
in rec {
  imports =
    [ # Include the results of the hardware scan.
    
      (./. + builtins.toPath "/hardware/${systemName}/configuration.nix")
      #./programs/sxhkd/default.nix
      ./programs/tor/default.nix
      ./xserver-i3.nix
    ];

  networking.firewall.enable = true;

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
    wget vim firefox 
  ];

  programs.vim.defaultEditor = true;

  # sound
  sound.enable = true;
  hardware.pulseaudio.enable = true;
  hardware.pulseaudio.daemon.config = {
    resample-method = "src-sinc-best-quality";
    default-sample-format = "float32le";
  };

  fonts = let 
   append = x: ["#{x} JP" "${x} SC" "${x} TC" "${x} KR"];
  in{
    # fonts = with pkgs; [ terminus_font freefont_ttf ];
    # fontconfig.defaultFonts = {
    #   monospace = [ "Terminus" ];
    #   sansSerif = [ "FreeSans" ];
    #   serif     = [ "FreeSerif" ];      
    # };
    fonts = with pkgs; [ anonymousPro freefont_ttf noto-fonts noto-fonts-cjk noto-fonts-emoji];
    fontconfig.allowBitmaps = false;
    fontconfig.defaultFonts.sansSerif = [ "FreeSans" "Noto Color Emoji" ] ++ append "Noto Sans CJK";
    fontconfig.defaultFonts.serif = [ "FreeSerif" "Noto Color Emoji" ] ++ append "Noto Sans";
    fontconfig.defaultFonts.monospace = [ "Anonymous Pro" "Noto Color Emoji"] ++ append "Noto Sans Mono";
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

}

