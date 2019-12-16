{ pkgs ? import <nixpkgs> {}, ...} :
with pkgs;
stdenv.mkDerivation {
  name = "build-and-commit";
  buildInputs = [ git ];
  shellHook = ''
    nixos-rebuild switch
    git add *
    git commit
    git push -u origin master
  '';

}
