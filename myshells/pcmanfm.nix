{ pkgs ? import <nixpkgs> {}, ... }:
with pkgs;
let
  name = "pcmanfm";
  pkg = pkgs."${name}";

in

stdenv.mkDerivation {
  name = "${name}-environment";
  buildInputs = [];
  shellHook = ''
    ${pkg}/bin/${name}
  '';
}
