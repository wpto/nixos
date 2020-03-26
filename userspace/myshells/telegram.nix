{ pkgs ? import <nixpkgs> {}, ... }:
with pkgs;
stdenv.mkDerivation {
  name = "telegram-environment";
  buildInputs = [];
  shellHook = ''
    ${tdesktop}/bin/telegram-desktop
  '';
}
