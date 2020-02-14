# Hi.

## To get started, do `sed -e 's/folder/toiba' README.md > configuration.nix`

    { config, pkgs, ... }:
    {
      imports = [
        ./folder
      ];
    } 
