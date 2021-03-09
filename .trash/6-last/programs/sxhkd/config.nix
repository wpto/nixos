{pkgs, ...}:
let
  some = "help";
in ''
  super + KP_Begin
      ${pkgs.i3}/bin/i3-nagbar -m "Hello from sxhkd config file"
''
