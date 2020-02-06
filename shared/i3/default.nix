{ config, pkgs, ... }:
let
  mod = "Mod4";
  st = import ./st { inherit pkgs; };

  gimpConfig = pkgs.writeText "gimp-config" (import ../shared/gimp-config.nix {});
  launchTerminal = ''exec ${st}/bin/st -f "Terminus:size=8"'';
  # ##????  terminus:size=8 and Terminus 12px are the same font ... ?-?
  fontPango = "Terminus 12px";
  
  highlightColor = "#FD971F"; # monokai.. love it

  # it's so messy. functions and settings are all together. ._.
  bindings = {
    q = "kill";
    w = w "qbittorrent";
    e = w "lxrandr";
    r = w "qutebrowser";
    t = "${(w "gimp")} --system-gimprc ${gimpConfig}";

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
    
    h = "focus left";
    j = "focus down";
    k = "focus up";
    l = "focus right";
  # semicolon = ""; 

    "Return" = launchTerminal;

    "Shift+h" = "move left";
    "Shift+j" = "move down";
    "Shift+k" = "move up";
    "Shift+l" = "move right";    

    "Shift+c" = "reload";
    "Shift+r" = "restart";

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
      status_command i3status
      position top
    }

    client.focused  ${highlightColor} ${highlightColor} ${highlightColor} ${highlightColor} ${highlightColor}
   
  '';
in {
  services.xserver.windowManager = {
    default = "i3";
    i3.enable = true;
    i3.configFile = pkgs.writeText "i3-config-file" configFile;
  };
}
