{ config, pkgs, ... }:
let
  sshAddress = "0.0.0.0";
  sshPort = "22";
in {
    services.openssh = {
    enable = true;
    permitRootLogin = "without-password";
    passwordAuthentication = false;
    listenAddresses = [{
      addr = sshAddress;
      port = sshPort;
    }];
  };
}
