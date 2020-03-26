{ config, pkgs, ... }:
let
  home = folder: "~/.config/mpd/" + folder;

in pkgs.writeText "mpd-config" ''
db_file            "${home "database"}"
log_file           "${home "log"}"
playlist_directory "${home "playlists"}"
pid_file           "${home "pid"}"
state_file         "${home "state"}"
sticker_file       "${home "sticker.sql"}"

music_directory "~/Music"

bind_to_address "127.0.0.1"
restore_paused "yes"
max_output_buffer_size "16384"

audio_output {
   type "pulse"
   name "mpd pulseaudio"
}
''
