{ config, pkgs, ... }:
{
  services.transmission = {
    enable = true;
    settings = {
      encryption = 2;
      "utp-enable" = false;
      "peer-port-random-on-start" = true;
      "rpc-host-whitelist-enabled" = false;
      "rpc-whitelist-enabled" = false;
      "download-dir" = "/home/kodi";
      "incomplete-dir" = "/home/kodi/.transmission-incomplete";
      "incomplete-dir-enable" = true;
    };
    user = "kodi";
    home = "/home/kodi/";
  };
 
}
