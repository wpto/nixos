{ config, pkgs, ... }:
let
  unstableTarball = (fetchTarball
      https://github.com/NixOS/nixpkgs-channels/archive/nixos-unstable.tar.gz);
    
  secret = import ../secret.nix;
in {
  nixpkgs.config = {
    allowUnfree = true;
    packageOverrides = pkgs: {
      unstable = import unstableTarball { config = config.nixpkgs.config;};
     #st = import ../shared/st { inherit pkgs; };
    };
  };

# programs.vim.defaultEditor = true;

  environment.shells = [pkgs.zsh pkgs.bashInteractive];
  environment.systemPackages = with pkgs; [
    git vim wget zathura
    nodejs nodePackages.nodemon nodePackages.coffee-script nodePackages.prettier
    sublime3 unzip ffmpeg
    _3llo
  ] ++ (with unstable; [ppsspp youtube-dl]);
  
  environment.shellAliases = {
    rmdir = "rm -rf";

    l = "ls -alh";
    ll = "ls -l";
    ls = "ls --color=tty";

    ga = "git add";
    gs = "git status";
    gc = "git commit -m";
    gt = "git tag";
    go = "git checkout";
    gl = "git --no-paper log --oneline --decorate --graph --all";
    gop = "go HEAD~ && gl";
    gom = "go master && gl";
    gu = "git reset --hard HEAD~";
    gg = "ga . && gc";
    gd = "git stash save --keep-index && git stash drop";
    gpu = "git push -u origin master";

    nb = "nix-build";
    ns = "nix-shell";
    n = ''echo "if you launch that more than 2 times then you need add it to systemPackages" && nix-shell -p'';
    sse = "cd /etc/nixos/ && sudo su";
    sw = "sudo nixos-rebuild switch -v";
    ru = "sudo su";
  # st = "cd /nix/store/";

    gulp = "gulp --require coffeescript/register";

    q = "exit";
    h = "history";

    "c1" = "cd ..";
    "c2" = "cd ../..";
    "c3" = "cd ../../..";
    "c4" = "cd ../../../..";

    pl = "cd ~/pl";
    pj = "cd ~/pj";

    bsy = ''browser-sync start --server --files './**' '';
    qui = "cd ~/quick/notes/";
    "display-off" = "sudo sh -c 'sleep 3; xset -display :0.0 dpms force off; read ans; xset -display :0.0 dpms force on'";
    #"displayoff" = "sudo sh -c 'sleep 1; xrandr --output LVDS-1 --off; read ans; xrandr --output LVDS-1 --auto'";

    "yt-audio" = ''youtube-dl -i --extract-audio --audio-format mp3 -o "%(title)s.%(ext)s"'';
    "3llo" = ''TRELLO_USER="${secret.trelloUser}" TRELLO_KEY="${secret.trelloKey}" TRELLO_TOKEN="${secret.trelloToken}" 3llo'';
  };

  programs.zsh = {
    enable = true;
    enableCompletion = true;
    enableGlobalCompInit = true;
    autosuggestions.enable = true;
    
  };
  
  environment.shellInit = ''

  '';
}
