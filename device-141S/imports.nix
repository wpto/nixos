{ config, pkgs, ... }: {
  imports = [ ./other.nix ./nginx-file-server.nix ./syncthing.nix];

  nixpkgs.config.allowUnfree = true;
  nixpkgs.config.packageOverride = pkgs: {
    #st = import ../user/st/default.nix { inherit pkgs; }; # fix same in other.nix environment.systemPackages # fix same in other.nix environment.systemPackages
    #dwm = import ../user/dwm/default.nix { inherit pkgs; };
  };

  services.xserver = {
    enable = true;
    layout = "us";
    xkbOptions = "grp_led:scroll,caps:swapescape";
    videoDrivers = [ "intel" ];

    desktopManager.xterm.enable = false;
    displayManager.defaultSession = "none+i3";
    #displayManager.defaultSession = "none+dwm";
    #displayManager.sessionCommands = import ../config/xresources.nix { inherit config pkgs; };

    displayManager.lightdm = {
      enable = true;
      autoLogin.enable = true;
      autoLogin.user = "ki";
    };

    windowManager.dwm.enable = true;
  } // (import ../programs/i3/default.nix {inherit pkgs;});

  services.compton = {
    enable = true;
    backend = "glx";
    vSync = true;
  };
}
