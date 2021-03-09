{ config, pkgs, ... }:
let
  mod = "Mod4";
  fontName = "Terminus Regular";
  fontSize = 12; # px
  toStr = builtins.toString;

  gradientStart = "#b4cbdd";
  gradientEnd   = "#403d55";
  gradientType  = "Vertical";

  fontPango = "${fontName} ${toStr fontSize}px";
  
  # highlightColor = "#FD971F"; # monokai.. love it
  highlightColor = "#1d2021";

  subl = "${pkgs.sublime3}/bin/subl";  
  ppsspp = "${pkgs.ppsspp}/bin/ppsspp";
  obs = "${pkgs.obs-studio}/bin/obs";

  exec = arg: "exec ${arg}";

  # it's so messy. functions and settings are all together. ._.
  bindings = import ./bindings.nix {inherit config pkgs;};


  generateWorkspace = nn: let num = builtins.toString nn; in ''
    bindsym ${mod}+${num} workspace number "${num}"
    bindsym ${mod}+Shift+${num} move container to workspace number "${num}"'';

  generateBinding = {name, value, ...}: ''bindsym ${mod}+${name} ${value}'';

  zipWithA = f: a: # applicative functor as you can see <*>. does anybody see this in pkgs.lib? # strange grammar. sorry
    if builtins.length a == 0
    then []
    else let
           ha = builtins.head a;
           hf = builtins.head f;
           ta = builtins.tail a;
           tf = builtins.tail f;
         in [(hf ha)] ++ zipWithA tf ta;

  configFile = ''
    #font: -xos4-terminus-*-*-*-*-*-*-*-*-*-*-iso10646-*

    exec ${pkgs.xorg.xmodmap}/bin/xmodmap -e "keycode 104 = Return"
    exec --no-startup-id '${pkgs.fluxbox}/bin/fbsetroot -display :0 -gradient "Vertical" -from "#b4cbdd" -to "#403d55"'
 
    floating_modifier ${mod}
    for_window [class=".*"] border pixel 1
    
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
    

    # bindings
    ${let
      config = bindings;
      concat = left: right: left + right;
      modAdded = builtins.attrNames config; #map (concat "${mod}") (builtins.attrNames config);
      pp = map pkgs.lib.nameValuePair modAdded;
      cc = zipWithA pp (builtins.attrValues config);
    in pkgs.lib.concatStringsSep "\n" (map generateBinding cc)}

    bar {
      # status_command ${import ./i3blocks.nix {inherit config pkgs;}} 
      # status_command i3status -c ${import ./i3status-config.nix {inherit config pkgs;}} 
      status_command i3status
      position top 
    }

    #  colors {
    #    background #000000
    #    focused_workspace ${highlightColor} ${highlightColor} #000000
    #    active_workspace #000000 #000000 #FFFFFF
    #    inactive_workspace #000000 #000000 #FFFFFF
    #    urgent_workspace ${highlightColor} #000000 #FFFFFF
    #  }

    #client.focused  ${highlightColor} ${highlightColor} ${highlightColor} ${highlightColor} ${highlightColor}
    #client.focused_inactive #000000 #000000 #000000 #000000 #000000
    #client.unfocused #000000 #000000 #000000 #000000 #000000
    #client.urgent #000000 #000000 #000000 #000000 #000000

    focus_follows_mouse no

    # exec_always --no-startup-id "${pkgs.mpd}/bin/mpd ${import ./mpd.nix {inherit config pkgs;}}"

    exec --no-startup-id '${pkgs.qbittorrent}/bin/qbittorrent'
  
    


  '';
in {
  services.xserver.windowManager = {
    # default = "i3";
    i3.enable = true;
    i3.configFile = pkgs.writeText "i3-config-file" configFile;
  };
}
