{ pkgs, config, ... }:
let
  a = 3;
in ''
  # black background
  exec_always --no-startup-id xsetroot
''
