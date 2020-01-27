{ config, pkgs, ... }:
{
  programs.zsh = {
    autosuggestions.enable = true;
    enable = true;
  }; 
}
