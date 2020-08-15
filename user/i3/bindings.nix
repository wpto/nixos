{ config, pkgs, ... }:

let 
  mod = "Mod4";
  st = import ../st { inherit pkgs; };
  launchInTerminal = "exec ${st}/bin/st";


  exe  = p: "exec ${builtins.getAttr p pkgs}/bin/${p}"; 
  exec = arg: "exec ${arg}";

in 
  with pkgs; {
    "F1" = "exec --no-startup-id ${pkgs.pulseaudio}/bin/pactl set-sink-mute   @DEFAULT_SINK@ toggle";
    "F2" = "exec --no-startup-id ${pkgs.pulseaudio}/bin/pactl set-sink-volume @DEFAULT_SINK@ -1%";
    "F3" = "exec --no-startup-id ${pkgs.pulseaudio}/bin/pactl set-sink-volume @DEFAULT_SINK@ +1%";

    q = "kill";
    w = exe "qbittorrent";
    e = exe "lxrandr";
    r = exe "qutebrowser";
    t = "layout tabbed";

    a = "focus parent";
    s = exe "scrot";
    d = "exec ${pkgs.writeShellScript "dmenu-environment" ''
      nix-shell "/etc/nixos/userspace/myshells/$(ls /etc/nixos/userspace/myshells | dmenu)"
    ''}";   
    f = "fullscreen toggle";
    g = ''${launchInTerminal} -e "${pkgs.htop}/bin/htop"'';

    z = "focus mode_toggle";
    x = "floating toggle";
    c = "split h";
    v = "split v";
    b = "layout toggle split";
    
    #y = "split h";
    p = exe "firefox";
    
    h = "focus left";
    j = "focus down";
    k = "focus up";
    l = "focus right";

    semicolon = exe "i3-easyfocus";
    # semicolon = "exec sudo ${subl} /etc/nixos/"; 
    #semicolon = exe "lxterminal";

    #n = exec ppsspp;
   # m = exec obs;
  # "," = "";
  # "." = "";
  # "/" = "";

    "Return" = launchInTerminal; #launchInTerminal;
    "KP_Enter" = launchInTerminal;

    "Shift+h" = "move left";
    "Shift+j" = "move down";
    "Shift+k" = "move up";
    "Shift+l" = "move right";    

    "Shift+c" = "reload";
    "Shift+r" = "restart";

}
