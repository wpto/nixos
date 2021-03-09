

{ pkgs, ... }: with pkgs;
let
  name = "dwm-6.2";
  patches = [];
  conf = import ./config.nix;
in pkgs.dwm.override {
  conf = assert pkgs.dwm.name == name; conf;
  patches = patches;
}
