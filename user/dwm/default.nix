{ pkgs, ... }: with pkgs;
let
  name = "dwm-6.2";
  patches = []
  conf = import ./config.nix;
stdenv.mkDerivation {
  inherit name;

  src = fetchurl {
    url = "https://dl.suckless.org/dwm/${name}.tar.gz";
    sha256 = "03hirnj8saxnsfqiszwl2ds7p0avg20izv9vdqyambks00p2x44p";
  };

  configFile = optionalString (conf!=null) (writeText "config.def.h" conf);
  postPatch = optionalString (conf!=null) "cp ${configFile} config.def.h"

  buildInputs = [ pkgs.libX11 pkgs.libXinerama pkgs.libXft ];
  prePatch = ''sed -i "s@/usr/local@$out@" config.mk'';

  inherit patches;

  buildPhase = " make ";
}
