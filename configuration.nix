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
      
      menuentry "Windows 8" {
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
  networking.wireless.enable = true;  # Enables wireless support via wpa_supplicant.

  networking.wireless.networks = {
    "Lesya_WiFi" = {
      pskRaw = "cfabe4cbc6473fc678e5aba10c67033cbbd7e518245fd40f650a87765be3de65";
    };
  };

  # Select internationalisation properties.
  # i18n = {
  #   consoleFont = "Lat2-Terminus16";
  #   consoleKeyMap = "us";
  #   defaultLocale = "en_US.UTF-8";
  # };

  # Set your time zone.
  time.timeZone = "Europe/Moscow";

  # List packages installed in system profile. To search, run:
  # $ nix search wget
  # environment.systemPackages = with pkgs; [
  #   wget vim
  # ];

  # networking.firewall.enable = false;

  # Enable CUPS to print documents.
  # services.printing.enable = true;

  # Enable sound.
  sound.enable = true;
  hardware.pulseaudio.enable = true;

  # Enable the X11 windowing system.
  services.xserver = {
    enable = true;
    videoDrivers = [ "intel" ];
    displayManager.lightdm.enable = true;
    windowManager.i3.enable = true;
    windowManager.dwm.enable = true;
    layout = "us,ru";
    xkbOptions = "grp:shifts_toggle, grp_led:scroll";
  };

  
  hardware.opengl.enable = true;

  fonts = {
    enableDefaultFonts = true;
    fonts = with pkgs; [
      terminus_font
      source-sans-pro
      source-serif-pro
    ];
  };

  services.compton = {
    enable = true;
    backend = "glx"; #glx xrender xr_glx_hybrid
    refreshRate = 60;
    vSync = "drm"; # opengl-swc drm opengl opengl-oml opengl-mswc 
  };

  # Ну нахер
  # programs.sway = {
  # enable = true;
  # extraSessionCommands = ''
  #   #define a keymap
  #   export XKB_DEFAULT_LAYOUT=us,ru
  #   export XKB_DEFAULT_OPTIONS=grp:shifts_toggle,grp_led:scroll
  # '';
  # };

  
  # services.xserver.xkbOptions = "eurosign:e";

  # Enable touchpad support.
  # services.xserver.libinput.enable = true;

  # Enable the KDE Desktop Environment.
  # services.xserver.displayManager.sddm.enable = true;
  # services.xserver.desktopManager.plasma5.enable = true;

  # Define a user account. Don't forget to set a password with ‘passwd’.
  # users.extraUsers.guest = {
  #   isNormalUser = true;
  #   uid = 1000;
  # };
  #
  users.mutableUsers = false;

  users.extraUsers.dt = {
    isNormalUser = true;
    description  = "Dmitry Titov";
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

  # This value determines the NixOS release with which your system is to be
  # compatible, in order to avoid breaking some software such as database
  # servers. You should change this only after NixOS release notes say you
  # should.
  system.stateVersion = "18.03"; # Did you read the comment?

}
