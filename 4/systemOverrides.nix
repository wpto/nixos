{ config, lib, pkgs, ... }:
{
  environment.systemPackages = [
    (import ../shared/st { inherit pkgs; })
  ];
}
