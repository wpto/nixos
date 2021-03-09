{ config, pkgs, interface, ssid, psk, internetSource, ... }:
{
  environment.etc."ap-${interface}-${ssid}" = {
    target = "NetworkManager/system-connections/ap-${interface}-${ssid}.nmconnection";
    text = ''
      [connection]
      id=AP
      uuid=b9432663-a467-485f-9650-aec990cdd962
      type=wifi
      interface-name=${interface}
      autoconnect=true
      permissions=

      [wifi]
      mac-address-blacklist=
      mode=ap
      ssid=${ssid}

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

  services.dhcpd4 = {
    enable = true;
    interfaces = [ interface ];
    extraConfig = ''
      subnet 10.0.0.0 netmask 255.255.255.0 {
        authoritative;
        range 10.0.0.2 10.0.0.254;
        default-lease-time 3600;
        max-lease-time 3600;
        option subnet-mask 255.255.255.0;
        option broadcast-address 10.0.0.255;
        option routers 10.0.0.1;
        option domain-name-servers 8.8.8.8;
      }
    '';
  };

  # networking.bridges."br0".interfaces = [ interface internetSource  ];
}
