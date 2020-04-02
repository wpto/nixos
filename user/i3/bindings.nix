{ config, pkgs, ... }:

let 
  mod = "Mod4";
  st = import ../st { inherit pkgs; };
  launchInTerminal = "exec ${st}/bin/st";


  exe  = p: "exec ${builtins.getAttr p pkgs}/bin/${p}"; 
  exec = arg: "exec ${arg}";

in 
  with pkgs; {
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

  # z = "";
    x = "focus mode_toggle";
    c = "floating toggle";
    v = "split v";
    b = "layout toggle split";
    
    y = "split h";
    u = "exec --no-startup-id ${pkgs.pulseaudio}/bin/pactl set-sink-volume @DEFAULT_SINK@ +1%";
    i = "exec --no-startup-id ${pkgs.pulseaudio}/bin/pactl set-sink-volume @DEFAULT_SINK@ -1%";
    o = "exec --no-startup-id ${pkgs.pulseaudio}/bin/pactl set-sink-mute   @DEFAULT_SINK@ toggle";
    # p = w "atom";
    
    h = "focus left";
    j = "focus down";
    k = "focus up";
    l = "focus right";

    semicolon = exe "i3-easyfocus";
    # semicolon = "exec sudo ${subl} /etc/nixos/"; 

    #n = exec ppsspp;
   # m = exec obs;
  # "," = "";
  # "." = "";
  # "/" = "";

    "Return" = launchInTerminal;

    "Shift+h" = "move left";
    "Shift+j" = "move down";
    "Shift+k" = "move up";
    "Shift+l" = "move right";    

    "Shift+c" = "reload";
    "Shift+r" = "restart";

}
