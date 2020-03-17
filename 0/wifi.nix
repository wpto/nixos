{ config, lib, pkgs, ... } :
{

  boot.kernel.sysctl = {
    "net.ipv4.ip_default_ttl" = 65;
  };

  networking = {
    useDHCP = false;

    interfaces.enp2s0.useDHCP = true;
    interfaces.wlp3s0.useDHCP = true;

    networkmanager.enable = true;
    networkmanager.packages = [
      pkgs.rpPPPoE
      pkgs.networkmanager_dmenu 
    ];

    wireless = {
      enable = false;
      networks = {
        "qqq".psk = "9999999998";
        "AndroidAPD5B2".psk = "movn6490";
#       "Lesya_WiFi".psk = "Liniya10";
        "TP-Link_9030".psk = "77302502";
        "wow wifi".psk = "12345679";
    };
  };
  };
}
