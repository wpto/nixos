{ config, pkgs, videoDrivers, user, ... }: {
  inherit videoDrivers;

  enable = true;
  layout = "us,ru";
  xkbOptions = "grp:win_space_toggle,grp_led:scroll,caps:swapescape,keypad:pointerkeys";
  desktopManager.xterm.enable = false;

  displayManager.defaultSession = "none+i3";

  displayManager.lightdm = {
    enable = true;
    autoLogin.enable = true;
    autoLogin.user = user;
  };

  displayManager.sessionCommands = ''
    xrdb -override ${pkgs.writeText "xresources-file" (import ./xresources.nix pkgs)};
  '';
}
