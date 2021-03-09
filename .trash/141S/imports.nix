{ config, pkgs, ... }: {
  imports = [
    ../system/users.nix
    ../system/other.nix

    ../system/tor
    ../system/fonts.nix
    ../system/compton.nix

    ../system/environment.nix
    ./touchpad.nix
  ];

  nixpkgs.config.allowUnfree = true;

  services.xserver = {
    enable = true;
    layout = "us";
    xkbOptions = "grp_led:scroll,caps:swapescape";
    videoDrivers = [ "intel" ];

    desktopManager.xterm.enable = false;
    displayManager.defaultSession = "none+i3";
    #displayManager.sessionCommands = import ../config/xresources.nix { inherit config pkgs; };

    displayManager.lightdm = {
      enable = true;
      autoLogin.enable = true;
      autoLogin.user = "ki";
    };

    windowManager.i3 = {
      enable = true;
      configFile = /etc/nixos/config/i3;
    };
  };
}
