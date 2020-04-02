{ config, pkgs, ... }:
{
  services.tor = {
    enable = true;
    client.enable = true;
    client.privoxy.enable = true;
    torsocks.enable = true;
    torsocks.server = "127.0.0.1:9050";
    torsocks.fasterServer = "127.0.0.1:9063";
  };
}
