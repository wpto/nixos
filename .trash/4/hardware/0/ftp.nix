{ config, pkgs, ...}:
let
  sharedDirectory = /home/ki/Desktop;
in {
  services.vsftpd = {
    anonymousUser = true;
    anonymousUserHome = sharedDirectory;
    anonymousUserNoPassword = true;
    enable = true;
  };
}
