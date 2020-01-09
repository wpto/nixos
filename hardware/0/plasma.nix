{ config, pkgs,... }:
{
  services.xserver = {
    enable = true;
    desktopManager.xterm.enable = false;

    desktopManager.plasma5.enable = true;
    desktopManager.plasma5.phononBackend = "vlc";

    videoDrivers = [ "intel" ];

    displayManager.auto.enable = true;
    displayManager.auto.user   = "ki";
  };
}
