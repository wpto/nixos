{pkgs, ...} :
let
  fg = "#ffffff";
  bg = "#000000";
  mod = "Mod1";
  palette = (background: border: text: childBorder: indicator: {inherit background border text childBorder indicator;});
  keys = (commands: builtins.listToAttrs 
    (map (x: {name = "${mod}+${x}"; value = (builtins.getAttr x commands);}) 
    (builtins.attrNames commands))); # thanks balsoft
in {
  enable = true;
  config = {
    /*
    colors = {
      background = bg;
      focused = palette fg fg bg fg fg;
      focusedInactive = palette bg bg fg bg bg;  
    };
    */
    
    keybindings = keys {
      "h" = "focus left";
      "j" = "focus down";
      "k" = "focus up";
      "l" = "focus right";

      "Shift + h" = "focus left";
      "Shift + j" = "focus down";
      "Shift + k" = "focus up";
      "Shift + l" = "focus right";

      "q" = "kill";
      "f" = "fullscreen toggle";

      "b" = "exec ${pkgs.chromium}/bin/chromium";
      "Return" = "exec ${pkgs.xterm}/bin/xterm";
    };
  };
} 
