{ pkgs ? import <nixpkgs> {}, ... }:
with pkgs;
let
  name = "obs-studio";
  pkg = pkgs."${name}";

in

stdenv.mkDerivation {
  name = "${name}-environment";
  buildInputs = [];
  shellHook = ''
    ${pkg}/bin/obs
  '';
}
