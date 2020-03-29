{ config, pkgs, ... }:
{
  users = {
    mutableUsers = false;
    defaultUserShell = pkgs.zsh;
  };

  users.extraUsers.root = {
    password = "";
  };

  users.extraUsers.ki = {
    isNormalUser = true;
    password = "";
    uid = 1000;
    extraGroups = [ "vboxusers" "networkmanager" ];
    useDefaultShell = true;
  };
 
  security.sudo = {
    enable = true;
    extraRules = [{
      groups = [ "users" ];
      commands = [{ command = "ALL"; options = [ "NOPASSWD" ]; }];
    }];
  };

}
