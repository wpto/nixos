{pkgs, ...} :
pkgs.xorg.xrandr.overrideAttrs (oldAttrs: rec {
  buildInputs = oldAttrs.buildInputs ++ (with pkgs; [automake115x gnum4 autoconf xorg.utilmacros pixman]);
  patches = [ ./xrandr-nearest.patch ];
})
