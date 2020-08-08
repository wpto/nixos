{ config, pkgs, ... }:
{
  fonts = {
    fonts = with pkgs; [
      freefont_ttf
      liberation_ttf
      noto-fonts-emoji
      source-han-sans-japanese
      source-han-serif-japanese
      terminus_font
      liberation_ttf
      ubuntu_font_family
    ];

    fontconfig = {
      enable = true;
      allowBitmaps = true;
      defaultFonts = {
        sansSerif = [ "FreeSans" "Source Han Sans JP" ];
        serif = [ "FreeSerif" "Source Han Serif JP" ];
        monospace = [ "Ubuntu Mono" "Terminus" "Liberation Mono" ];
        emoji = [ "Noto Color Emoji" ];
      };
    };
    
    enableDefaultFonts = false;
  };
}
