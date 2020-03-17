{config, pkgs, ...} :
let
  configFile = import ./config.nix pkgs;
in {
  # setup daemon autostart
  systemd.user.services.sxhkd = {
    enable = true;
    description = "Simple X Hotkey Daemon";

    after = [ "graphical-session-pre.target" ];
    partOf = [ "graphical-session.target" ];

    reload = "kill -SIGUSR1 sxhkd";
    script = "${pkgs.sxhkd}/bin/sxhkd -c ${pkgs.writeText "sxhkd-config-file" configFile}";

    wantedBy = [ "graphical-session.target" ];
  };
}
