{ config, pkgs, ... }:
{
  fonts = {
    fonts = with pkgs; [
      freefont_ttf
      liberation_ttf
      noto-fonts-emoji
      source-han-sans-japanese
      source-han-serif-japanese
    ];

    fontconfig = {
      enable = true;
      allowBitmaps = false;
      defaultFonts = {
        sansSerif = [ "FreeSans" "Source Han Sans JP" ];
        serif = [ "FreeSerif" "Source Han Serif JP" ];
        monospace = [ "Liberation Mono" ];
        emoji = [ "Noto Color Emoji" ];
      };
    };
    
    enableDefaultFonts = false;
  };
}
