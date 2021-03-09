{ config, pkgs, ... }: {
  services.compton = {
    enable = true;
    backend = "glx";
    vSync = true;
  };
}
