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

  nmcli-checker = pkgs.writeShellScript "wifi-script" ''
    TYPE=$type
    OUT=$(${nmcli} device | ${egrep} "\s$TYPE\s")
    INTERFACE=$(echo $OUT | ${awk} '{print $1}' | ${trim})
    CONNECTION=$(echo $OUT | ${awk} '{$1=$2=$3=""; print $0}' | ${trim})

    if [ $CONNECTION = "--" ]
    then
      printf '{"full_text":"%s","color":"%s"}' $INTERFACE "${purple}"
    else
      printf '{"full_text":"%s","color":"%s"}' $CONNECTION "${green}"
    fi
  '';
in
pkgs.writeShellScript "i3blocks-script" ''
  ${i3blocks} -c ${pkgs.writeText "i3blocks-config" ''

    [ethernet]
    type=ethernet
    command=${nmcli-checker}
    interval=5
    format=json

    [wifi]
    type=wifi
    command=${nmcli-checker}
    interval=5
    format=json

    [time]
    command=date "+%A %F %T"
    interval=5
  ''}
''
