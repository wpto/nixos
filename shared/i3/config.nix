{ config, pkgs, lib,
  generateBindings,
  exec, 
  bindsym,
  generateWorkspace
  ... }:
let

  mod = "Mod4";
  
  fontPango = "";

in

''

font pango: ${fontPango}
floating_modifier ${mod}
for_window [class=".*"] border pixel 1

bindsym 0 workspace number "10"
bindsym Shift+0 move container to workspace number "10"

${
  lib.concatStringsSep "\n" (map generateWorkspace (builtins.genList (x: x+1) 9))
}

bar {
  status_command i3status --config ${i3status-config}
}

client.focused ${highlightColor} ${highlightColor} ${highlightColor} ${highlightColor} ${highlightColor}
client.focused_inactive  ${backgroundColor} ${backgroundColor} ${backgroundColor} ${backgroundColor} ${backgroundColor}
client.unfocused  ${backgroundColor} ${backgroundColor} ${backgroundColor} ${backgroundColor} ${backgroundColor}
client.urgent ${highlightColor} ${highlightColor} ${highlightColor} ${highlightColor} ${highlightColor}

exec_always --no-startup-id ${pkgs.fluxbox}/bin/fbsetroot -display :0 -gradient "${gradientType}" -from "${gradientStart}" -to "${gradientEnd}"

# default mode ||
${ generateBindings {
  q = "kill";
  w = exec "qbittorrent";
  e = exec "lxrandr";
  r = exec "qutebrowser";
  t = exec "gimp"

  a = "focus parent";
  s = exec "scrot";

  d = exec (pkgs.writeShellScript "my-dmenu" ''
    nix-shell "/etc/nixos/myshells/$(ls /etc/nixos/myshells | ${pkgs.dmenu}/bin/dmenu)"
  '');

  f = "fullscreen toggle";
  g = terminal "${pkgs.htop}/bin/htop";

# z = "";
  x = "focus mode_toggle";
  c = "floating toggle";
  v = "split v";
  b = "layout toggle split";

  y = "split h";
  u = "exec --no-startup-id ${pkgs.pulseaudio}/bin/pactl set-sink-volume @DEFAULT_SINK@ -1%";
  i = "exec --no-startup-id ${pkgs.pulseaudio}/bin/pactl set-sink-volume @DEFAULT_SINK@ +1%";
  o = "exec --no-startup-id ${pkgs.pulseaudio}/bin/pactl set-sink-mute   @DEFAULT_SINK@ toggle";
# p = "";

  h = "focus left";
  j = "focus down";
  k = "focus up";
  l = "focus right";
# semicolon = "";

  "Return" = terminal;

  "Shift+h" = "move left";
  "Shift+j" = "move down";
  "Shift+k" = "move up";
  "Shift+l" = "move right";

  "Shift+c" = "reload";
  "Shift+r" = "restart";

}}

# input mode || i3 doesn't handle input
${bindsym "i" ''mode "Write Mode"''}

mode "Write Mode" {
  ${bindsym "${mod}" ''mode "default"''}
}

  

'';
