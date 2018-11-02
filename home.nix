{ pkgs, ... }:

let
  theme = builtins.fromJSON (builtins.readFile /home/dt/.config/nixpkgs/gruvbox-dark-soft.json);
in {
  programs.home-manager = {
    enable = true;
    path = https://github.com/rycee/home-manager/archive/release-18.03.tar.gz;
  };

  home.keyboard = {
    option = [ "grp:shifts_toggle" "grp_led:scroll" ];
    layout = "us,ru";
  };

  programs.vim = {
    enable = true;
    settings = {
      tabstop = 2;
      expandtab = false;
      shiftwidth = 2;
      number = true;
    };
    extraConfig = ''
      syntax match Tab /\t/
      hi Tab cterm=underline ctermfg=blue ctermbg=blue
    '';
  };

  programs.termite = {
    enable = true;
    foregroundColor = "#${theme.base05}";
    foregroundBoldColor = "#${theme.base06}";
    cursorColor = "#${theme.base06}";
    cursorForegroundColor = "#${theme.base00}";
    backgroundColor = "#${theme.base00}";
    font = "Terminus 8";
   
    colorsExtra = ''
      color0 = #${theme.base00}
      color1 = #${theme.base08}
      color2 = #${theme.base0B}
      color3 = #${theme.base0A}
      color4 = #${theme.base0D}
      color5 = #${theme.base0E}
      color6 = #${theme.base0C}
      color7 = #${theme.base05}
      color8 = #${theme.base03}
      color9 = #${theme.base08}
      color10 = #${theme.base0B}
      color11 = #${theme.base0A}
      color12 = #${theme.base0D}
      color13 = #${theme.base0E}
      color14 = #${theme.base0C}
      color15 = #${theme.base07}

      color16 = #${theme.base09}
      color17 = #${theme.base0F}
      color18 = #${theme.base01}
      color19 = #${theme.base02}
      color20 = #${theme.base04}
      color21 = #${theme.base06}
    '';
  };

  programs.bash = {
    enable = true;
    sessionVariables = {
      "LC_ALL" = "ru_RU.utf8";
    };
    # shellAliases = {
    # };
  };

  programs.git = {
    enable = true;
    userEmail = "gtdsocial@icloud.com";
    userName  = "vadacpp";
  };

  programs.feh.enable = true;

  
  xsession.windowManager.i3 = import ./i3.nix pkgs;
  
  /*
      window.commands = [ {
        command = "border pixel 3";
        criteria = { class = "^.*"; };  
      } ];
    };
  };
  */
}
