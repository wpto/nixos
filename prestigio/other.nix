{ config, pkgs, ... }:
{
  users = {
    mutableUsers = false;
    defaultUserShell = pkgs.zsh;

    extraUsers.root.password = "";
    extraUsers.ki = {
      isNormalUser = true;
      password = "";
      uid = 1000;
      extraGroups = [ "vboxusers" "networkmanager" ];
      useDefaultShell = true;
    };
  };

 
  security.sudo = {
    enable = true;
    extraRules = [{
      groups = [ "users" ];
      commands = [{ command = "ALL"; options = [ "NOPASSWD" ]; }];
    }];
  };

  networking.firewall = {
    enable = true;
    allowedTCPPorts = [ 8001 8999 3000 3001 ];
    allowedTCPPortRanges = [{ from = 6881; to = 6889; }];
  };

  time.timeZone = "Europe/Moscow";

  sound.enable = true;
  hardware.pulseaudio.enable = true;
  hardware.pulseaudio.daemon.config = {
    resample-method = "src-sinc-best-quality";
    default-sample-format = "float32le";
  };

  services.tor = let
    serverAddress = "127.0.0.1:9050";
    fasterServerAddress = "127.0.0.1:9063";
  in {
    enable = true;
    client.enable = true;
    client.privoxy.enable = true;
    torsocks.enable = true;    
    torsocks.server = serverAddress;
    torsocks.fasterServer = fasterServerAddress;
  }; 

  fonts = {
    fonts = with pkgs; [
      freefont_ttf
      liberation_ttf
      noto-fonts-emoji
      source-han-sans-japanese
      source-han-serif-japanese
      terminus_font
      terminus_font_ttf
      tewi-font
      liberation_ttf
      # ubuntu_font_family
    ];

    fontconfig = {
      enable = true;
      allowBitmaps = true;
      defaultFonts = {
        sansSerif = [ "FreeSans" "Source Han Sans JP" ];
        serif = [ "FreeSerif" "Source Han Serif JP" ];
        monospace = [ "Terminus" "Liberation Mono" ]; # "Ubuntu Mono"];
        emoji = [ "Noto Color Emoji" ];
      };
    };
    
    enableDefaultFonts = false;
  };

  nixpkgs.config = {
    allowUnfree = true;
    #packageOverrides = pkgs: {
    #  unstable = import unstableTarball { config = config.nixpkgs.config;};
    # #st = import ../shared/st { inherit pkgs; };
    #};
  };

# programs.vim.defaultEditor = true;

  environment.shells = [pkgs.zsh pkgs.bashInteractive];
  environment.systemPackages = with pkgs; [
    git vim wget zathura
    nodejs
    sublime3 unzip ffmpeg
    steam
    #_3llo
    entr
  ];# ++ (with unstable; [ppsspp youtube-dl]);
  
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
    gf = "git fetch";
    gp = "git pull";
    gpp = "gf && gp";

    nb = "nix-build";
    ns = "nix-shell";
    #n = ''echo "if you launch that more than 2 times then you need add it to systemPackages" && nix-shell -p'';
    sse = "cd /etc/nixos/ && sudo su";
    sw = "sudo nixos-rebuild switch -v";
    ru = "sudo su";
  # st = "cd /nix/store/";


    q = "exit";
    h = "history";

    "c1" = "cd ..";
    "c2" = "cd ../..";
    "c3" = "cd ../../..";
    "c4" = "cd ../../../..";


    qui = "cd ~/quick/notes/";
    "display-off" = "sudo sh -c 'sleep 3; xset -display :0.0 dpms force off; read ans; xset -display :0.0 dpms force on'";
    #"displayoff" = "sudo sh -c 'sleep 1; xrandr --output LVDS-1 --off; read ans; xrandr --output LVDS-1 --auto'";

    "yt-audio" = ''youtube-dl -i --extract-audio --audio-format mp3 -o "%(title)s.%(ext)s"'';
    #"3llo" = ''TRELLO_USER="${secret.trelloUser}" TRELLO_KEY="${secret.trelloKey}" TRELLO_TOKEN="${secret.trelloToken}" 3llo'';

    "vlc" = "${pkgs.vlc}/bin/vlc --qt-minimal-view --fullscreen";
    "dl" = "cd ~/Downloads";
    "pl" = "cd ~/Playground";

    # node specific stuff - TODO: fix repeated strings
    bsy = ''./node_modules/.bin/browser-sync start --server --files './**' '';
    gulp = "./node_modules/.bin/gulp --require coffeescript/register";
    coffee = "./node_modules/.bin/coffee";
    cake = "./node_modules/.bin/cake";
    prettier = "./node_modules/.bin/prettier";
    nodemon = "./node_modules/.bin/nodemon";

    node-watch = ''find ./ -not -path './node_modules/*' -not -path './.git/*' | entr sh -c '';

  };


  programs.zsh = {
    enable = true;
    enableCompletion = true;
    enableGlobalCompInit = true;
    autosuggestions.enable = true;
  };
  
  environment.shellInit = ''

  '';

  services.xserver.libinput = {
    enable = true;
  };

  console.font = "Lat2-Terminus16";
 # console.keyMap = "us";
  console.useXkbConfig = true;

  i18n.inputMethod = {
    enabled = "fcitx";
    fcitx.engines = with pkgs.fcitx-engines; [ mozc m17n ];
  };
}
