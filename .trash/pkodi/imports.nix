{ config, pkgs, ... }: {
  imports = [ ./other.nix ./nginx-file-server.nix];

  nixpkgs.config.allowUnfree = true;
  nixpkgs.config.packageOverride = pkgs: {
    st = import ../user/st/default.nix { inherit pkgs; };
    #dwm = import ../user/dwm/default.nix { inherit pkgs; };
  };

  services.xserver = {
    enable = true;
    layout = "us";
    xkbOptions = "grp_led:scroll,caps:swapescape";
    videoDrivers = [ "intel" ];

    desktopManager.xterm.enable = false;
    displayManager.defaultSession = "kodi";
    #displayManager.defaultSession = "none+dwm";
    #displayManager.sessionCommands = import ../config/xresources.nix { inherit config pkgs; };

    displayManager.lightdm = {
      enable = true;
      autoLogin.enable = true;
      autoLogin.user = "ki";
    };

#    windowManager.i3 = {
      #enable = true;
      #configFile = /etc/nixos/config/i3;
    #};

    #windowManager.dwm.enable = true;

    desktopManager.kodi.enable = true;
  };

  services.compton = {
    enable = true;
    backend = "glx";
    vSync = true;
  };
}
