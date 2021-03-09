{ config, pkgs, ...}:
{
  i18n = {
    consoleFont = "Lat2-Terminus16";
    consoleKeyMap = "us";
    inputMethod = {
      enabled = "fcitx";
      fcitx.engines = with pkgs.fcitx-engines; [ mozc m17n ];
    };
  };
}
