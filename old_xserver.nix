{ config, pkgs, ... }:
{
  services.xserver = {
    enable = true;
    layout = "us,ru";
    xkbOptions = "grp:win_space_toggle,grp_led:scroll,caps:swapescape";
    
    desktopManager.xterm.enable = false;

    displayManager.auto = {
      enable = true;
      user = "ki";
    };
    
    windowManager = {
      default = "i3";
      i3.enable = true;
      i3.configFile = pkgs.writeText "i3-config-file" (import ./programs/i3/config.nix pkgs);
    };

  };
}
