{config, pkgs, ...} :
let
  configFile = import ./config.nix pkgs;
in {
  # setup daemon autostart
  systemd.services.sxhkd = {
    enable = true;
    description = "Simple X Hotkey Daemon";
    documentation = "man:sxhkd(1)";
   
    after = [ "display-manager.service" ];
    bindsTo = [ "display-manager.service" ];
   
    serviceConfig = {
      ExecStart = "${pkgs.sxhkd}";
      ExecReload = "${
    };
    script = "${pkgs.sxhkd}";
    scriptArgs = "-c ${pkgs.writeText "sxhkd-config-file" configFile}";
    wantedBy = [ "graphical.target" ];
  };
}
