{ config, pkgs, ... }:
let
	activeColor = "#FD971F";
	b = key: command: "bindsym $mod+${key} ${command}\n";
in pkgs.writeText "i3-config-file" ''
set $mod Mod4

exec ${pkgs.xorg.xmodmap}/bin/xmodmap -e "keycode 104 = Return"
exec --no-startup-id '${pkgs.fluxbox}/bin/fbsetroot -display :0 -gradient "Vertical" -from "#b4cbdd" -to "#403d55"'

exec --no-startup-id ${pkgs.networkmanagerapplet}/bin/nm-applet
 
floating_modifier $mod
for_window [class=".*"] border pixel 1
focus_follows_mouse no

bindsym F1 exec --no-startup-id ${pkgs.pulseaudio}/bin/pactl set-sink-mute   @DEFAULT_SINK@ toggle
bindsym F2 exec --no-startup-id ${pkgs.pulseaudio}/bin/pactl set-sink-volume @DEFAULT_SINK@ -3%";
bindsym F3 exec --no-startup-id ${pkgs.pulseaudio}/bin/pactl set-sink-volume @DEFAULT_SINK@ +3%";

''
+b "q" "kill"
+b "w" "nix-shell -p qbittorrent --run qbittorrent"
+b "e" "nix-shell -p lxrandr --run lxrandr"
+b "r" "nix-shell -p qutebrowser --run qutebrowser"
+b "t" "layout tabbed"

# +b "a" "focus parent"
+b "s" "nix-shell -p scrot --run scrot"
# +b "a" "" # dmenu
+b "f" "fullscreen"
+b "g" "nix-shell -p htop --run htop"

+b "z" "focus mode_toggle"
+b "x" "floating toggle"
+b "c" "split h"
+b "v" "split v"
+b "b" "layout toggle split"

+b "h" "focus left"
+b "j" "focus down"
+b "k" "focus up"
+b "l" "focus right"
+b "semicolon" "nix-shell -p i3-easyfocus --run i3-easyfocus"

+b "Shift+h" "move left"
+b "Shift+j" "move down"
+b "Shift+k" "move up"
+b "Shift+l" "move right"

+b "Shift+r" "restart"

+b "Return" "${pkgs.lxterminal}/bin/lxterminal"
+b "KP_Enter" "${pkgs.lxterminal}/bin/lxterminal"

+''




bar {
	status_command i3status
	position top 
}

colors {
	background #000000
	focused_workspace ${activeColor} ${activeColor} #000000
	active_workspace #000000 #000000 #FFFFFF
	inactive_workspace #000000 #000000 #FFFFFF
	urgent_workspace ${activeColor} #000000 #FFFFFF
}

set $ws1 "1"
set $ws2 "2"
set $ws3 "3"
set $ws4 "4"
set $ws5 "5"
set $ws6 "6"
set $ws7 "7"
set $ws8 "8"
set $ws9 "9"
set $ws10 "10"
    
bindsym $mod+1 workspace number $ws1
bindsym $mod+2 workspace number $ws2
bindsym $mod+3 workspace number $ws3
bindsym $mod+4 workspace number $ws4
bindsym $mod+5 workspace number $ws5
bindsym $mod+6 workspace number $ws6
bindsym $mod+7 workspace number $ws7
bindsym $mod+8 workspace number $ws8
bindsym $mod+9 workspace number $ws9
bindsym $mod+0 workspace number $ws10

bindsym $mod+Shift+1 move container to workspace number $ws1
bindsym $mod+Shift+2 move container to workspace number $ws2
bindsym $mod+Shift+3 move container to workspace number $ws3
bindsym $mod+Shift+4 move container to workspace number $ws4
bindsym $mod+Shift+5 move container to workspace number $ws5
bindsym $mod+Shift+6 move container to workspace number $ws6
bindsym $mod+Shift+7 move container to workspace number $ws7
bindsym $mod+Shift+8 move container to workspace number $ws8
bindsym $mod+Shift+9 move container to workspace number $ws9
bindsym $mod+Shift+0 move container to workspace number $ws10
''
