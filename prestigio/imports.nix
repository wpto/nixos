{ config, pkgs, ... }: {
  imports = [ ./other.nix ./nginx-file-server.nix];

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

  services.compton = {
    enable = true;
    backend = "glx";
    vSync = true;
  };
}
