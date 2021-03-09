{ config, pkgs, lib, ... }:
let
  rootDirectory = "/home/ki/shared/";
  configText = ''
    events {
    }
    http {
      server {
        listen 8001;
        autoindex on;
        autoindex_exact_size off;
        autoindex_localtime on;
        location / {
          root ${rootDirectory};
        }
      }
    }''; 
in {
  #networking.firewall.enable = true;
  #networking.firewall.allowedTCPPorts = pkgs.lib.mkBefore [ 80 ];
  #networking.firewall.allowedUDPPorts = pkgs.lib.mkBefore [ 80 ];

  services.nginx = {
    enable = true;
    config = configText;
    user = "ki";
    group = "users";
  }; 
}
