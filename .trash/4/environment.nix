{ config, pkgs, ... }:
let
  unstableTarball = fetchTarball
    https://github.com/NixOS/nixpkgs-channels/archive/nixos-unstable.tar.gz;
in {
  nixpkgs.config = {
    allowUnfree = true;
    packageOverrides = pkgs: { unstable = import unstableTarball { config = config.nixpkgs.config;}; st = import ../shared/st { inherit pkgs; };  };
  };

# programs.vim.defaultEditor = true;

  environment.shells = [pkgs.zsh pkgs.bashInteractive];
  environment.systemPackages = with pkgs; [
    git vim wget zathura unstable.ppsspp
    nodejs nodePackages.nodemon nodePackages.coffee-script
  ];
  
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
    sw = "sudo nixos-rebuild switch";
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

    bsy = "browser-sync start --server --files '*'";
    qui = "cd ~/quick/notes/";
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
