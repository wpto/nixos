{ config, pkgs, ... }:
let
  userSettings = {};
in {
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
      i3.configFile = pkgs.writeText "i3-config-file" (import ./config/i3.nix pkgs);
    };

    displayManager.sessionCommands = ''
      xrdb -override ${pkgs.writeText "xresources-file" (import ./config/xresources.nix pkgs)};
    '';

  };
}
