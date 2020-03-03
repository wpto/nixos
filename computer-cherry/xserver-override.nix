{ config, pkgs, lib, ...}: 
let
  sessionCommands = config.services.xserver.displayManager.sessionCommands;
in {
  disabledModules = [
    ../shared/i3
    ../toiba/xserver.nix
  ];

  services.xserver = {
    enable = true;
    layout = "us,ru";
    xkbOptions = "grp:win_space_toggle,grp_led:scroll,caps:swapescape";
    videoDrivers = [ "nvidia" ];

    desktopManager.xterm.enable = false;

    displayManager.auto = {
      enable = true;
      user = "ki";
    };
       
    displayManager.sessionCommands = ''
      xrandr --output DVI-D-0 --auto --left-of DVI-I-0
    '';
    
    windowManager = {
      default = "i3";
      i3.enable = true;
      i3.configFile = import ../common/i3 { inherit config pkgs lib; };
    };
  };
}
