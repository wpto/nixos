{pkgs, ...} :
let
  fg = "#ffffff";
  bg = "#000000";
  mod = "Mod1";
  palette = (background: border: text: childBorder: indicator: {inherit background border text childBorder indicator;});
  keys = (mod: bind@{...}: map (x)
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
    
    keybindings = {
      "${mod} + h" = "focus left";
      "${mod} + j" = "focus down";
      "${mod} + k" = "focus up";
      "${mod} + l" = "focus right";

      "${mod} + Shift + h" = "focus left";
      "${mod} + Shift + j" = "focus down";
      "${mod} + Shift + k" = "focus up";
      "${mod} + Shift + l" = "focus right";

      //packages
      "${mod} + b" = "exec ${pkgs.chromium}/bin/chromium";
    };
  };
} 
