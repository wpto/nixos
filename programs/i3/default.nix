{ pkgs, ... }: {
  windowManager.i3 = {
    enable = true;
    configFile = /etc/nixos/programs/i3/config;
    extraSessionCommands = ''
      xrandr --output eDP1 --filter nearest --scale 0.5x0.5
    '';

  };
}
