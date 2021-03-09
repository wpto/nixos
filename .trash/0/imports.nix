{ config, pkgs, ... }:
{
  imports = [
    ./users.nix
    ./other.nix
    
    ../system/tor
    ./xserver.nix
    ../user/i3
    ./environment.nix
    ./zsh.nix
    ./nginx-file-server.nix
  ];

  nixpkgs.config.allowUnfree = true;
}
