{ pkgs ? import <nixpkgs> {}, ... }:
with pkgs;
let
  name = "chromium";
  pkg = pkgs."${name}";

in

stdenv.mkDerivation {
  name = "${name}-environment";
  buildInputs = [];
  shellHook = ''
    ${pkg}/bin/${name}
  '';
}
