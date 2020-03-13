{ config, pkgs, ... }:
let
  mod = "Mod4";
  st = import ../st { inherit pkgs; };
  fontName = "Terminus";
  fontSize = 12; # px
  toStr = builtins.toString;

  gradientStart = "#b4cbdd";
  gradientEnd   = "#403d55";
  gradientType  = "Vertical";

  launchTerminal = ''exec ${st}/bin/st -f "${fontName}:size=${toStr (fontSize / 4 * 3)}"'';
  # ##????  terminus:size=8 and Terminus 12px are the same font ... ?-?
  fontPango = "${fontName} ${toStr fontSize}px";
  
  # highlightColor = "#FD971F"; # monokai.. love it
  highlightColor = "#AE81FF";

  

  subl = "${pkgs.sublime3}/bin/subl";  

  exec = arg: "exec ${arg}";

  # it's so messy. functions and settings are all together. ._.
  bindings = {
    q = "kill";
    w = w "qbittorrent";
    e = w "lxrandr";
    r = w "qutebrowser";
  #  t = "${(w "gimp")} --system-gimprc ${gimpConfig}";

    a = "focus parent";
    s = w "scrot";
    d = "exec dmenu_run";    
    f = "fullscreen toggle";
    g = ''${launchTerminal} -e "${pkgs.htop}/bin/htop"'';

    z = "exec ${pkgs.writeShellScript "dmenu-environment" ''
      nix-shell "/etc/nixos/myshells/$(ls /etc/nixos/myshells | dmenu)"
    ''}";
    x = "focus mode_toggle";
    c = "floating toggle";
    v = "split v";
    b = "layout toggle split";
    
    y = "split h";
    u = "exec --no-startup-id ${pkgs.pulseaudio}/bin/pactl set-sink-volume @DEFAULT_SINK@ +1%";
    i = "exec --no-startup-id ${pkgs.pulseaudio}/bin/pactl set-sink-volume @DEFAULT_SINK@ -1%";
    o = "exec --no-startup-id ${pkgs.pulseaudio}/bin/pactl set-sink-mute   @DEFAULT_SINK@ toggle";
    p = w "atom";
    
    h = "focus left";
    j = "focus down";
    k = "focus up";
    l = "focus right";
    semicolon = "exec sudo ${subl} /etc/nixos/"; 

    n = exec subl;
  # m = ;
  # "," = "exec sudo nixos-rebuild switch && i3-msg restart";
  # "." = exec subl;
  # "/" = "";

    "Shift+n" = "exec sudo nixos-rebuild switch && i3-msg restart";
  # "Shift+m" = ;


    "Return" = launchTerminal;

    "Shift+h" = "move left";
    "Shift+j" = "move down";
    "Shift+k" = "move up";
    "Shift+l" = "move right";    

    "Shift+c" = "reload";
    "Shift+r" = "restart";

    #"i" = ''${launchTerminal} -e "HOME=' ' ${pkgs.emacs}/bin/emacsclient"'';
  };

  w = p: "exec ${builtins.getAttr p pkgs}/bin/${p}"; 

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

    font pango: ${fontPango}
 
    floating_modifier ${mod}
    for_window [class=".*"] border pixel 1
    
    # workspaces
    ${pkgs.lib.concatStringsSep "\n" (map generateWorkspace (builtins.genList (x: x+1) 9))}

    bindsym ${mod}+0 workspace number "10"
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
      status_command i3status --config ${pkgs.writeText "i3-status-config" (import ./i3-status-config.nix {inherit config pkgs;})}
      position top
    }

    client.focused  ${highlightColor} ${highlightColor} ${highlightColor} ${highlightColor} ${highlightColor}
    client.focused_inactive #000000 #000000 #000000 #000000 #000000
    client.unfocused #000000 #000000 #000000 #000000 #000000
    client.urgent #000000 #000000 #000000 #000000 #000000

    exec_always --no-startup-id ${pkgs.fluxbox}/bin/fbsetroot -display :0 -gradient "${gradientType}" -from "${gradientStart}" -to "${gradientEnd}"

    focus_follows_mouse no
  '';
in pkgs.writeText "i3-config-file" configFile
