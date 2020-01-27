# Hi.

## To get started, do `sed -e 's/folder/something' README.md > configuration.nix`

    { config, pkgs, ... }:
    {
      imports = [
        ./folder
      ];
    } 
