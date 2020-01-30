{ pkgs ? import <nixpkgs> {}, ... }:
with pkgs;
stdenv.mkDerivation {
  name = "blender-environment";
  buildInputs = [];
  shellHook = ''
    ${blender}/bin/blender
  '';
}
