{ pkgs ? import <nixpkgs> {}, ... }:
with pkgs;
stdenv.mkDerivation {
  name = "firefox-environment";
  buildInputs = [];
  shellHook = ''
    ${firefox}/bin/firefox
  '';
}
