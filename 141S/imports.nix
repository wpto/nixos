{ config, pkgs, ... }: {
  imports = [
    ../system/users.nix
    ../system/other.nix

    ../system/tor
    ../system/fonts.nix
    ../system/compton.nix

    ../system/environment.nix
    ../user/i3
  ];

  nixpkgs.config.allowUnfree = true;

  services.xserver = import ../system/xserver {
    inherit config pkgs;
    videoDrivers = [ "intel" ];
    user = "ki";
  };
}
