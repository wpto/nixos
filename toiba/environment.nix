{ config, pkgs, ... }:
{
  nixpkgs.config.allowUnfree = true;

  programs.vim.defaultEditor = true;

  environment.shells = [pkgs.zsh pkgs.bashInteractive];
  environment.systemPackages = with pkgs; [
    git vim wget zathura
  ];
  
  environment.shellAliases = {
    # ls = "ls --color=tty";
    # ll = "ls -l";
    # l  = "ls -alh";
    rmdir = "rm -rf";

    l = "ls -alh";
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

    gulp = "gulp --require coffeescript/register";

    q = "exit";
    h = "history";

    ".." = "cd ..";
    "..." = "cd ../..";
    "...." = "cd ../../..";

    pl = "cd ~/pl";

  };

  environment.shellInit = ''

  '';
}
