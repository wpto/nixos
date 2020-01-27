{ config, lib, pkgs, ... } :
{

  boot.kernel.sysctl = {
    "net.ipv4.ip_default_ttl" = 65;
  };

  networking.useDHCP = false;
  networking.networkmanager.enable = false;
  networking.wireless = {
    enable = true;
    networks = {
      "qqq".psk = "9999999998";
      "AndroidAPD5B2".psk = "movn6490";
      "Lesya_WiFi".psk = "Liniya10";
      "TP-Link_9030".psk = "77302502";
    };
  };
}
