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

    displayManager.sessionCommands = ''
      xrdb -override ${pkgs.writeText "xresources-file" (import ./xresources.nix pkgs)};
    '';

  };
}
