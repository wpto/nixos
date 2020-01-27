{ config, pkgs, ... }:
{
  networking.firewall.enable = true;
  networking.firewall.allowedTCPPorts = [

  # kodi
    (mkIf desktopManager.kodi.enable 8080)
    (mkIf desktopManager.kodi.enable 9777)

  # ssh
    (mkIf services.openssh 22)

  # transmission webserver
    (mkIf config.service.transmission.enable 9091)
  ];
}
