{ config, pkgs, ... }: {

  environment.etc.dmsd = {
    target = "NetworkManager/system-connections/dmsd.nmconnection";
    text = ''
      [connection]
      id=DMSD Connection
      uuid=a9432663-a467-485f-9650-aec990cdd962
      type=pppoe
      autoconnect=true
      permissions=
      timestamp=1584475415

      [ethernet]
      mac-address-blacklist=

      [pppoe]
      password=145527022017
      username=20681

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
}
