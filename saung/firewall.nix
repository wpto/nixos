{ config, pkgs, ... }:
with pkgs.lib; {
  networking.firewall.enable = true;
  networking.firewall.allowedTCPPorts = [

  # kodi web server
    (mkIf config.services.xserver.desktopManager.kodi.enable 8080)

  # ssh
    (mkIf config.services.openssh.enable 22)

  # transmission webserver
    (mkIf config.services.transmission.enable 9091)
  ];

  networking.firewall.allowedUDPPorts = [

  # kodi event server
    (mkIf config.services.xserver.desktopManager.kodi.enable 9777)

  ];
}
