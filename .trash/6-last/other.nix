{ config, pkgs, ... }:
{
  networking.firewall = {
    enable = true;
    allowedTCPPorts = [ 8001 8999 3000 3001 ];
    allowedTCPPortRanges = [{ from = 6881; to = 6889; }];
  };

  time.timeZone = "Europe/Moscow";

  sound.enable = true;
  hardware.pulseaudio.enable = true;
  hardware.pulseaudio.daemon.config = {
    resample-method = "src-sinc-best-quality";
    default-sample-format = "float32le";
  };
}
