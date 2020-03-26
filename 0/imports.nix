{ config, pkgs, ... }:
{
  imports = [
    ./users.nix
    ./other.nix
    
    ../shared/tor
    ./xserver.nix
    ../userspace/i3
    ./environment.nix
    ./zsh.nix
    ../shared/emacs
    ./nginx-file-server.nix
  ];

  nixpkgs.config.allowUnfree = true;
}
