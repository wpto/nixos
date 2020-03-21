{ config, pkgs, ... } :
let
  wifi = ssid: psk: {
    target = "NetworkManager/system-connections/wifi-${ssid}.nmconnection";
    text = ''
      [connection]
      id=${ssid}
      type=wifi
      permission=
      autoconnect=true

      [wifi]
      mac-address-blacklist=
      mode=infrastructure
      ssid=${ssid}

      [wifi-security]
      auth-alg=open
      key-mgmt=wpa-psk
      psk=${psk}

      [ipv4]
      dns-search=
      method=auto

      [ipv6]
      addr-gen-mode=stable-privacy
      dns-search=
      method=auto
    '';
    mode = "600";
  };

in {

  boot.kernel.sysctl."net.ipv4.ip_default_ttl" = 65;
  environment.etc."wifi-AP" = wifi "AP" "Grogesco7114kwhx";


#  networking = {
#    wireless = {
#      enable = false;
#      networks = {
#        "qqq".psk = "9999999998";
#        "AndroidAPD5B2".psk = "movn6490";
#       "Lesya_WiFi".psk = "Liniya10";
#        "TP-Link_9030".psk = "77302502";
#        "wow wifi".psk = "12345679";
#    };
#  };
#  };

  
}
