# Hi.

To get started, create `configuration.nix`

    { config, pkgs, ... }:
    {
      imports = [
        ./path/to/configuration.nix
      ];
    } 
