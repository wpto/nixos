{ config, pkgs, ... }:
''
general {
  output_format = "i3bar"
  colors = true
  interval = 5
}


order += "volume master"
order += "1pv6"
order += "disk /"
order += "disk /home"
order += "run_watch DHCP"
order += "wireless wlp3s0"
order += "ethernet eth0"
order += "cpu_temperature 0"
order += "memory"
order += "load"
order += "tztime local"

wireless wlp3s0 {
  format_up = "W: (%quality at %essid, %bitrate) %ip"
  format_down = "W"
}

ethernet eth0 {
  format_up = "E: %ip (%speed)"
  format_down = "E"
}

run_watch DHCP {
  pidfile = "/var/run/dhcpcd*.pid"
}

tztime local {
  format = "%Y-%m-%d %H:%M:%S"
}

load {
  format = "L: %1min %5min %15min"
}

cpu_temperature 0 {
  format = "T: %degrees °C"
  path = "/sys/devices/platform/coretemp.0/hwmon/hwmon0/temp1_input"
}

memory {
  format = "M: %used"
  threshold_degraded = "10%"
  format_degraded = "MEMORY: %free"
}

disk "/" {
  format = "/: %free"
}

disk "/home" {
  format = "H: %free"
}

volume master {
  format = "♪: %volume"
  format_muted = "♪: muted"
  device = "default"
  mixer = "Master"
  mixer_idx = 0
}
''
