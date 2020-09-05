{ config, pkgs, ... }:
pkgs.writeText "i3status-config" ''
general {
  colors = true
  interval = 5
}


order += "volume master"
order += "disk /"
order += "disk /home"
order += "cpu_temperature 0"
order += "memory"
order += "battery 0"
order += "load"
order += "tztime local"

tztime local {
  format = "%Y-%m-%d %H:%M:%S"
}

load {
  format = "L: %1min %5min %15min"
}

battery 0 {
	format = "%status %percentage %remaining %emptytime"
        format_down = "No battery"
        status_chr = "⚇ CHR"
        status_bat = "⚡ BAT"
        status_full = "☻ FULL"
        path = "/sys/class/power_supply/BAT%d/uevent"
        low_threshold = 10
}

cpu_temperature 0 {
  format = "T: %degrees °C"
  path = "/sys/devices/platform/coretemp.0/temp1_input"
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
  format_muted = "♪"
  device = "default"
  mixer = "Master"
  mixer_idx = 0
}
''
