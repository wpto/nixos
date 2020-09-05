{ config, pkgs, ... }:
let
	activeColor = "#FD971F";
	b = key: command: "bindsym $mod+${key} ${command}\n";
	st = import ../user/i3 { inherit config pkgs; };
	stExe = "${st}/bin/st";
in pkgs.writeText "i3-config" ''
set $mod Mod4

exec --no-startup-id ${pkgs.xorg.xmodmap}/bin/xmodmap -e "keycode 104 = Return"
exec --no-startup-id ${pkgs.fluxbox}/bin/fbsetroot -display :0 -gradient "Vertical" -from "#b4cbdd" -to "#403d55"

exec --no-startup-id ${pkgs.networkmanagerapplet}/bin/nm-applet
 
floating_modifier $mod
for_window [class=".*"] border pixel 1
focus_follows_mouse no

bindsym $mod+F1 exec --no-startup-id ${pkgs.pulseaudio}/bin/pactl set-sink-mute   @DEFAULT_SINK@ toggle
bindsym $mod+F2 exec --no-startup-id ${pkgs.pulseaudio}/bin/pactl set-sink-volume @DEFAULT_SINK@ -3%";
bindsym $mod+F3 exec --no-startup-id ${pkgs.pulseaudio}/bin/pactl set-sink-volume @DEFAULT_SINK@ +3%";

bindsym $mod+q kill
bindsym $mod+w exec nix-shell -p qbittorrent --run qbittorrent
bindsym $mod+e exec nix-shell -p lxrandr --run lxrandr
bindsym $mod+r exec nix-shell -p qutebrowser --run qutebrowser
bindsym $mod+t layout tabbed

# bindsym a focus parent
bindsym $mod+s exec nix-shell -p scrot --run scrot
# bindsym a " # dmenu
bindsym $mod+f fullscreen
bindsym $mod+g exec nix-shell -p htop --run htop

bindsym $mod+z focus mode_toggle
bindsym $mod+x floating toggle
bindsym $mod+c split h
bindsym $mod+v split v
bindsym $mod+b layout toggle split

bindsym $mod+p exec nix-shell -p firefox --run firefox

bindsym $mod+h focus left
bindsym $mod+j focus down
bindsym $mod+k focus up
bindsym $mod+l focus right
bindsym $mod+semicolon nix-shell -p i3-easyfocus --run i3-easyfocus

bindsym $mod+Shift+h move left
bindsym $mod+Shift+j move down
bindsym $mod+Shift+k move up
bindsym $mod+Shift+l move right

bindsym $mod+Shift+r restart

bindsym $mod+Return exec ${stExe}
bindsym $mod+KP_Enter exec ${stExe}

bar {
	status_command i3status
	position top 
}

client.background #000000

client.focused ${activeColor} ${activeColor} ${activeColor} ${activeColor} ${activeColor}
client.focused_active #000000 #000000 #000000 #000000 #000000
client.unfocused #000000 #000000 #000000 #000000 #000000

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
