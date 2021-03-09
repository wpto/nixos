{ pkgs, ... }:
pkgs.st.override {
  conf = assert pkgs.st.name == "st-0.8.2"; import ./config.nix;
  patches = [ ./st-newterm-0.8.2.diff ./st-clipboard-0.8.2.diff ./st-gruvbox-dark-0.8.2.diff  ];
}
