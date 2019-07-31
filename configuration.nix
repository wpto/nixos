#q Edit this configuration file to define what should be installed on
# your system.  Help is available in the configuration.nix(5) man page
# and in the NixOS manual (accessible by running ‘nixos-help’).

{ config, pkgs, ... }:
{
  nixpkgs.config.allowUnfree = true;
  imports = [ ./hardware-configuration.nix ];

  fileSystems."/" = {
    device = "/dev/disk/by-label/nixos";
    fsType = "ext4";      
  };

  swapDevices = [ { device = "/dev/disk/by-label/swap"; } ];

  # Use the GRUB 2 boot loader.
  boot = {
    loader.grub = {
      enable = true;
      version = 2;
      device = "/dev/sda"; # or "nodev" for efi only
      useOSProber = true;
    };
    
    kernel.sysctl = {
      "net.ipv4.ip_default_ttl" = 65;
    };
  };
  networking.hostName = "nixos";
  networking.wireless = {
    enable = true;
    networks = {
      "Lesya_WiFi".pskRaw = "cfabe4cbc6473fc678e5aba10c67033cbbd7e518245fd40f650a87765be3de65";
      "Thunderbird".pskRaw = "d10ff16e6d23e42958e9f76af1369970c49ea1077d55b3ad78e78e3318366fc6";
      "RT-WiFi_574D".pskRaw = "1195d1f7509bebb537886f0592812b6ba4a1dbd6c2856c9182bf65829db5a612";
      "10101" = {
         pskRaw = "5767794e8c48d7fee755d7051e7e1d0173d55890d30bb61f12da50c051c5a02f";
         hidden = true;
      };
    };
  };

  i18n = {
    consoleFont = "Lat2-Terminus16";
    consoleKeyMap = "us";
    defaultLocale = "en_US.UTF-8";
  };

  time.timeZone = "Europe/Moscow";

  environment.systemPackages = with pkgs; [
    wget vim firefox zathura tdesktop pavucontrol milkytracker
  ];



  # Enable sound.
  sound.enable = true;
  hardware.pulseaudio.enable = true;

# Enable the X11 windowing system.
  services.xserver = {
    enable = true;
    synaptics.enable = true;

    displayManager.auto = {
      enable = true;
      user = "nixuser";
    };

    desktopManager.xterm.enable = false;

    windowManager = {
      default = "i3";
      i3.enable = true;
    };
      
    layout = "us,ru";
    xkbVariant = "colemak,";
    xkbOptions = "grp:alt_shift_toggle,grp_led:scroll,caps:swapescape";

    videoDrivers = ["intel"];
  };

  
  hardware.opengl = {
    enable = true;
    driSupport = true;
    extraPackages = with pkgs; [ xorg.xf86videointel ];
  };

  fonts = {
    enableDefaultFonts = true;
    fonts = with pkgs; [
      terminus_font
    # inconsolata
    # libertine
    # source-code-pro
    # source-sans-pro
    # source-serif-pro
    ];
    fontconfig.defaultFonts = {
      monospace = [ "terminus_font" ];
      sansSerif = [ "FreeSans" ];
      serif     = [ "FreeSerif" ];  
    };
  };

  services.compton = {
    enable = true;
    backend = "glx"; #glx xrender xr_glx_hybrid
    refreshRate = 60;
    vSync = "opengl-swc"; # opengl-swc drm_slow opengl_slow opengl-oml_slow opengl-mswc_strange
  };

  users.mutableUsers = false;

  users.extraUsers.nixuser = {
    isNormalUser = true;
    description  = "";
    password     = ""; 
    uid = 1000;
  };

  users.users.root = {
    password = "";
  };

  services.tor = {
    enable = true;
    client.enable = true;
    client.privoxy.enable = true;
    torsocks.enable = true;
  };

  security.sudo = {
    enable = true;
    extraRules = [{
      commands = [{
        command = "ALL";
        options = [ "NOPASSWD" ];
      }];
      groups   = [ "users" ];
    }];
  };

  services.openssh = {
    enable = true;
    listenAddresses = [ { addr = "0.0.0.0"; port = 22; } ];
  };



  system.stateVersion = "19.03";

}
