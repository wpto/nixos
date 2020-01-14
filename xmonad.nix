{ config, pkgs, ... }:
{
  services.xserver.windowManager = {
    default = "xmonad";
    xmonad.enable = true;
    xmonad.enableContribAndExtras = true;
    #xmonad.config = '' '';
    # xmonad.extraPackages = [];
    # xmonad.haskellPackages = [];
  };
}
