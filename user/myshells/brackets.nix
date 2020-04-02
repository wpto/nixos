{ pkgs ? import <nixpkgs> {}, ... }:
with pkgs;
let
  name = "brackets";
  pkg = pkgs."${name}";

in

stdenv.mkDerivation {
  name = "${name}-environment";
  buildInputs = [];
  shellHook = ''
    ${pkg}/bin/${name}
  '';
}
