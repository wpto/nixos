{ config, pkgs, ...}: 

let
  i3blocks = "${pkgs.i3blocks}/bin/i3blocks";

  i3status = "${pkgs.i3status}/bin/i3status";
  i3statusConfig = import ./i3status-config.nix {inherit config pkgs;};

  nmcli = "${pkgs.networkmanager}/bin/nmcli";
  egrep = "${pkgs.busybox}/bin/egrep";
  awk   = "${pkgs.busybox}/bin/awk";
  sed   = "${pkgs.busybox}/bin/sed";
  trim  = " sed 's/^ *//;s/ *$//' ";

  purple = "#F92672";
  green = "#A6E22E";

  nmcli-script = pkgs.writeShellScript "nmcli-script" ''
    CONNECTION=$(${nmcli} device | ${egrep} '\sconnected\s' | ${awk} '{$1=$2=$3=""; print $0}' | ${trim})
    echo $CONNECTION
    echo $CONNECTION
    echo "${green}"
    exit 0
  '';
in
#    [ethernet]
#    type=ethernet
#    command=${nmcli-checker}
#    interval=5
#    format=json

#    [wifi]
#    type=wifi
#    command=${nmcli-checker}
#    interval=5
#    format=json

pkgs.writeShellScript "i3blocks-script" ''
  ${i3blocks} -c ${pkgs.writeText "i3blocks-config" ''
    [nmcli]
    interval=10
    command=${nmcli-script}

    [time]
    command=date "+%A %F %T"
    interval=5
  ''}
''
