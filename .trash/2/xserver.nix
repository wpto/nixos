{ config, pkgs, ...}:
rec {
  hardware.opengl = {
    driSupport32Bit = true;
    enable = true;
  };

  services.xserver = {
    enable = true;
    layout = "us,ru";
    xkbOptions = "grp:alt_shift_toggle,grp_led:scroll";
  # videoDrivers = [ "nvidiaLegacy390" ];

    desktopManager.xterm.enable = false;
    desktopManager.kodi.enable  = true;

    displayManager.auto = {
      enable = true;
      user   = "kodi";
    };
  };

  fonts = {
    fonts = with pkgs; [ terminus_font freefont_ttf ];
    fontconfig.defaultFonts = {
      monospace = [ "Terminus" ];
      sansSerif = [ "FreeSans" ];
      serif     = [ "FreeSerif" ];
    };
  }; 

  services.compton = {
    enable = true;
    backend = "glx";
    vSync = true;
  };
}
