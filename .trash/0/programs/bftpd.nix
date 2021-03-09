{ config, pkgs, ... }:
let
  hh = builtins.head;
  tt = builtins.tail;
  rootDir = "/home/ki/";
  generateConfig = global: let
    process = key: value: 
      if (builtins.length key) == 0
      then ""
      else "${hh key}=${hh value}\n${process (tt key) (tt value)}";
    in  
''
global {
${process (map (pkgs.lib.toUpper) (builtins.attrNames global)) (builtins.attrValues global)}
}'';
  configSet = (generateConfig {
      deny_login = "no";
      port = "21";
      passive_ports = "0";
      dataport20 = "no";
      admin_pass = "x";
      path_bftpdutmp = "";
      xfer_bufsize="64000";
      change_bufsize = "no";
      xfer_delay = "0";
      show_hidden_files = "no";
      show_nonreadable_files = "yes";
      allow_fxp = "yes";
      control_timeout = "300";
      data_timeout = "30";
      ratio = "none";
      rootdir = rootDir;
      umask = "022";
      logfile = "";
      hello_string = "bftpd %v at %i ready.";
      auto_chdir = "/";
      auth = "PASSWD";
      resolve_client_ip = "no";
      motd_global = pkgs.writeText "bftpd-motd-global-file" "Welcome!";
      motd_user = pkgs.writeText "bftpd-motd-user-file" "%u %h";
      resolve_uids = "yes";
      do_chroot = "yes";
      log_wtmp = "no";
      bind_to_addr = "any";
      path_ftpusers = "/that-file-not-exist";
      auth_etcshells = "no";
      allowcommand_dele = "no";
      allowcommand_stor = "yes";
      allowcommand_site = "no";
      hide_group = "";
      quit_msg = "See you later...";

      userlimit_global="0";
      userlimit_singleuser = "0";
      userlimit_host = "0";
      gz_upload = "no";
      gz_download = "no";
    }) + ''
user ftp {
  ANONYMOUS_USER="yes"
  DENY_LOGIN="no"
  ROOTDIR=${rootDir}
}

user anonymous {
  ALIAS="ftp"
}

user root {
  DENY_LOGIN="Root login not allowed."
}'';

  pkgsBinPath = "${pkgs.bftpd}/bin/bftpd";
  configPath = "${pkgs.writeText "bftpd-config-file" configSet}";
in {

  networking.firewall.enable = true;
  networking.firewall.allowedTCPPorts = pkgs.lib.mkBefore [ 21 ];
  networking.firewall.allowedUDPPorts = pkgs.lib.mkBefore [ 21 ];
  
  systemd.services.bftpd = {
    enable = true;
    description = "bftpd daemon";

    serviceConfig = {
      Type = "forking";
      ExecStart = "${pkgsBinPath} -d -c ${configPath}";
      GuessMainPID = "yes";
    };
    
    wantedBy = ["multi-user.target"];
  };

  systemd.sockets.bftpd = {
    description = "bftpd incoming socket";
    conflicts = [ "bftpd.service" ];
    
    socketConfig = {
      ListenStream = "21";
      Accept = "yes";
    };

    wantedBy = [ "sockets.target" ];
  };

  systemd.services."bftpd@" = {
    enable = true;
    
    serviceConfig = {
      ExecStart = "${pkgsBinPath} -i -c ${configPath}";
      StandartInput = "socket";
      StandartOutput = "socket";
      StandartError = "socket";
    };
  };
}
