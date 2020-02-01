{ config, pkgs, ... }:
{
  imports = [
    ./users.nix
    ./other.nix
    
    ../shared/tor
    ./xserver.nix
    ./i3.nix
    ./environment.nix
    ./zsh.nix
  ];
}
