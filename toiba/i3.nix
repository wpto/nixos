{ config, pkgs, ... }:
let
  mod = "Mod4";
  st = import ./st { inherit pkgs; };
  generateWorkspace = num: ''
    bindsym ${mod}+${num} workspace number "${num}"
    bindsym ${mod}+Shift+${num} move container to workspace number "${num}"
  '';
  configFile = ''
    floating_modifier ${mod}
    
    for_window [class=".*"] border pixel 1

    bindsym ${mod}+Return exec ${st}/bin/st

    bindsym ${mod}+Shift+j move left
    bindsym ${mod}+Shift+k move down 
    bindsym ${mod}+Shift+l move up 
    bindsym ${mod}+Shift+semicolon move right




    bindsym ${mod}+1 workspace number "1"
    bindsym ${mod}+2 workspace number "2"
    bindsym ${mod}+3 workspace number "3"
    bindsym ${mod}+4 workspace number "4"
    bindsym ${mod}+5 workspace number "5"

    bindsym ${mod}+6 workspace number "6"
    bindsym ${mod}+7 workspace number "7"
    bindsym ${mod}+8 workspace number "8"
    bindsym ${mod}+9 workspace number "9"
    bindsym ${mod}+0 workspace number "10"


    bindsym ${mod}+Shift+1 move container to workspace number "1"
    bindsym ${mod}+Shift+2 move container to workspace number "2"
    bindsym ${mod}+Shift+3 move container to workspace number "3"
    bindsym ${mod}+Shift+4 move container to workspace number "4"
    bindsym ${mod}+Shift+5 move container to workspace number "5"

    bindsym ${mod}+Shift+6 move container to workspace number "6"
    bindsym ${mod}+Shift+7 move container to workspace number "7"
    bindsym ${mod}+Shift+8 move container to workspace number "8"
    bindsym ${mod}+Shift+9 move container to workspace number "9"
    bindsym ${mod}+Shift+0 move container to workspace number "10"
    
    bindsym ${mod}+Shift+c reload
    bindsym ${mod}+Shift+r restart

     
    bindsym ${mod}+q kill
    bindsym ${mod}+w exec ${pkgs.qbittorrent}/bin/qbittorrent
    bindsym ${mod}+e exec ${pkgs.lxrandr}/bin/lxrandr
    bindsym ${mod}+r exec ${pkgs.firefox}/bin/firefox
    bindsym ${mod}+t exec ${pkgs.gimp}/bin/gimp
   
    bindsym ${mod}+a focus parent
    bindsym ${mod}+s exec ${pkgs.scrot}/bin/scrot
    bindsym ${mod}+d exec dmenu_run
    bindsym ${mod}+f fullscreen toggle
    bindsym ${mod}+g exec ${st}/bin/st -e "${pkgs.htop}/bin/htop"

    bindsym ${mod}+z exec ${pkgs.writeShellScript "dmenu-environment" ''
      nix-shell "/etc/nixos/myshells/$(ls /etc/nixos/myshells | dmenu)"
    ''}
    bindsym ${mod}+x focus mode_toggle
    bindsym ${mod}+c floating toggle 
    bindsym ${mod}+v split v
    bindsym ${mod}+b layout toggle split

# yuiop
    bindsym ${mod}+y split h

    bindsym ${mod}+h focus left
    bindsym ${mod}+j focus down
    bindsym ${mod}+k focus up
    bindsym ${mod}+l focus right
#   bindsym ${mod}+semicolon 

# nm,./

    bar {
      status_command i3status
      position top
    }
   
  '';
in {
  services.xserver.windowManager = {
    default = "i3";
    i3.enable = true;
    i3.configFile = pkgs.writeText "i3-config-file" configFile;
  };
}
