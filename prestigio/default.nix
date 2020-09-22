{ config, pkgs, ... }: {
  imports = [
    ./hardware.nix
    ./imports.nix
  ];

  boot.loader.systemd-boot.enable = true;
  boot.loader.efi.canTouchEfiVariables = true;

  boot.kernel.sysctl."net.ipv4.ip_default_ttl" = 65;
  hardware.opengl.driSupport32Bit = true;

  networking = {
    wireless = {
      enable = true;
      networks = {
        "AP".psk = "234234234";
        "Lesya_WiFi".psk = "Liniya10";
      };
    };
  };

  networking.useDHCP = false;
  networking.interfaces.wlp0s21f0u7i2.useDHCP = true;

  system.stateVersion = "20.03";
}
