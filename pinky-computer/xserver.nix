{ config, pkgs, ... }:
let
  userSettings = {};
in {
  imports = [
    ./fonts.nix
  ];

  services.xserver = {
    enable = true;
    layout = "us,ru";
    xkbOptions = "grp:win_space_toggle,caps:swapescape";
 #   videoDrivers = [ "intel" ];
    
    desktopManager.xterm.enable = false;

    displayManager.auto = {
      enable = true;
      user = "ki";
    };

    displayManager.sessionCommands = ''
      xrdb -override ${pkgs.writeText "xresources-file" (import ./xresources.nix pkgs)};
    '';

  };

 #  services.compton = {
 #   enable = true;
    # backend = "glx";
 #   vSync = true;
 # };
}
