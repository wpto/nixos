{ config, pkgs, ... } : 
let
  serverAddress = "127.0.0.1:9050";
  fasterServerAddress = "127.0.0.1:9063";
in {
  services.tor = {
    enable = true;
    client.enable = true;
    client.privoxy.enable = true;
    torsocks.enable = true;    
    torsocks.server = serverAddress;
    torsocks.fasterServer = fasterServerAddress;
  }; 
}
