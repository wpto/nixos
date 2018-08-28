{pkgs, ...} :
let
  fg = "#ffffff";
  bg = "#000000";
  mod = "Mod1";
  palette = (background: border: text: childBorder: indicator: {inherit background border text childBorder indicator;});
in {
  enable = true;
  config = {
    colors = {
      background = bg;
      focused = palette fg fg bg fg fg;
      focusedInactive = palette bg bg fg bg bg;  
    };
  };
} 
