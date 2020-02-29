{ pkgs ? import <nixpkgs> {}, ... }:
with pkgs;
let
  name = "tor-browser-bundle";
  pkg = pkgs."${name}";

in

stdenv.mkDerivation {
  name = "${name}-environment";
  buildInputs = [];
  shellHook = ''
    ${pkg}/bin/${name}
  '';
}
