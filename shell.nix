{ pkgs ? import <nixpkgs> {}, ...} :
with pkgs;
stdenv.mkDerivation {
  name = "build-and-commit";
  buildInputs = [ git ];
  shellHook = ''
    nixos-rebuild switch
    git config user.email "gtdsocial@icloud.com"
    git config user.name  "umgi"
    git commit -a
    git push -u origin master
  '';
}
