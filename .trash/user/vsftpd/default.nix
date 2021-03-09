{config, pkgs, ...} : let
  a = 2;
in pkgs.writeText "vsftpd-config" ''
  write_enable=YES
  
  anonymous_enable=YES
  no_anon_password=YES
  anon_mkdir_write_enable=YES
  anon_upload_enable=YES
  background=YES
  listen=YES
''
