# please make a function
{ config, pkgs, lib, ...} :
let
  user = "ki";
  group = "users";
  configDir = "/home/ki/.config/syncthing/prestigio";
  dataDir = "/home/ki/";
in {
  services.syncthing = {
    enable = true;
    openDefaultPorts = true;
    inherit user group configDir dataDir;
  };
}
