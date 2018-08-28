# Edit this configuration file to define what should be installed on
# your system.  Help is available in the configuration.nix(5) man page
# and in the NixOS manual (accessible by running ‘nixos-help’).

{ config, pkgs, ... }:

{
  imports =
    [ # Include the results of the hardware scan.
      /etc/nixos/hardware-configuration.nix
    ];

  # Use the GRUB 2 boot loader.
  boot.loader.grub = {
    enable = true;
    version = 2;
    device = "/dev/sda"; # or "nodev" for efi only

    extraEntries = ''
      menuentry "Windows 10" {
        insmod part_msdos
        insmod ntfs
        insmod search_fs_uuid
        insmod ntldr
        search --fs-uuid --set=root --hint-bios=hd0,msdos1 --hint-efi=hd0,msdos1 --hint-baremetal=achi0,msdos1 5214543714541FF1
        ntldr /bootmgr
      }

      menuentry "System restart" {
        echo "System rebooting..."
        reboot
      }      

      menuentry "System shutdown" {
        echo "System shutting down..."
        halt
      }
    '';
  };

  networking.hostName = "nixos"; # Define your hostname.
  networking.wireless = {
    enable = true;
    networks = {
      "Lesya_WiFi".pskRaw = "cfabe4cbc6473fc678e5aba10c67033cbbd7e518245fd40f650a87765be3de65";
      "Thunderbird".pskRaw = "d10ff16e6d23e42958e9f76af1369970c49ea1077d55b3ad78e78e3318366fc6";
    };
  };

  i18n = {
    consoleFont = "Lat2-Terminus16";
    consoleKeyMap = "us";
    defaultLocale = "en_US.UTF-8";
  };

  time.timeZone = "Europe/Moscow";

  # List packages installed in system profile. To search, run:
  # $ nix search wget
  # environment.systemPackages = with pkgs; [
  #   wget vim
  # ];



  # Enable sound.
  sound.enable = true;
  hardware.pulseaudio.enable = true;

  # Enable the X11 windowing system.
  services.xserver = {
    enable = true;
    autorun = false;
    videoDrivers = [ "intel" ];
    libinput.enable = true;
    displayManager.lightdm.enable = true;
    windowManager.i3.enable = true;
    layout = "us,ru";
    xkbOptions = "grp:shifts_toggle,grp_led:scroll";
  };

  
  hardware.opengl = {
    enable = true;
    driSupport = true;
  };

  fonts = {
    enableDefaultFonts = true;
    fonts = with pkgs; [
      terminus_font
      inconsolata
      libertine
      source-code-pro
      source-sans-pro
      source-serif-pro
    ];
    fontconfig.defaultFonts.monospace = [ "terminus_font" ];
  };

  services.compton = {
    enable = true;
    backend = "glx"; #glx xrender xr_glx_hybrid
    refreshRate = 60;
    vSync = "opengl-swc"; # opengl-swc drm_slow opengl_slow opengl-oml_slow opengl-mswc_strange
  };

  users.mutableUsers = false;

  users.extraUsers.dt = {
    isNormalUser = true;
    description  = "Dmitry Titov";
    password     = ""; 
    uid = 1000;
  };

  users.extraUsers.git = {
    password = "";
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



  system.stateVersion = "18.03"; # Did you read the comment?

}
