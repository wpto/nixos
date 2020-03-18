{ config, pkgs, ... }:
(import ../nm/ap.nix {
  inherit config pkgs;
  interface = "wlp3s0";
  ssid = "AP";
  psk = "qqqqqqqq1";
  internetSource = "enp2s0";
})
