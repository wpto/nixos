{ config, pkgs, ... }:
{
  services.xserver.windowManager = {
    default = "xmonad";
    xmonad.enable = true;
    xmonad.enableContribAndExtras = true;
    # xmonad.extraPackages = [];
    # xmonad.haskellPackages = [];
    xmonad.config = ''

    '';
  };
}
