{ config, pkgs, ... }:
let
  userSettings = {};
in {
  services.xserver.windowManager = {
    default = "i3";
    i3.enable = true;
    i3.configFile = pkgs.writeText "i3-config-file" (import ./config/i3.nix pkgs);
  };
}
