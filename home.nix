{ pkgs, ... }:

{
  programs.home-manager = {
    enable = true;
    path = https://github.com/rycee/home-manager/archive/release-18.03.tar.gz;
  };

  programs.vim = {
    enable = true;
    settings = {
      tabstop = 2;
      expandtab = false;
      shiftwidth = 2;
      number = true;
    };
    extraConfig = ''
      syntax match Tab /\t/
      hi Tab cterm=underline ctermfg=blue ctermbg=blue
    '';
  };

  programs.bash = {
    enable = true;
    sessionVariables = {
      "LC_ALL" = "en_US.utf8";
    };
    # shellAliases = {
    # };
  };

  programs.git = {
    enable = true;
    userEmail = "gtdsocial@icloud.com";
    userName  = "vadacpp";
  };

  programs.feh.enable = true;
  xsession.windowManager.i3 = import ./i3.nix pkgs;
}
