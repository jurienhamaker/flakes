{ lib, fetchFromGitHub, meson, ninja, mkDerivation }:

mkDerivation rec {
  pname = "waynergy";
  version = "0.0.15";

  src = fetchFromGitHub {
    owner = "r-c-f";
    repo = pname;
    rev = "v${version}";
    fetchSubmodules = true;
  };

  buildInputs = [  ];
  nativeBuildInputs = [ 
    meson
    ninja
  ];

  meta = {
    description = "An implementation of a synergy client for wayland compositors.";
    longDescription = ''
      An implementation of a synergy client for wayland compositors. Based on the upstream uSynergy library (heavily modified for more protocol support and a bit of paranoia).
    '';
    homepage = "https://github.com/r-c-f/waynergy";
    downloadPage = "https://github.com/r-c-f/waynergy";
    license = lib.licenses.mit;
    maintainers = [ lib.maintainers.r-c-f ];
    platforms = lib.platforms.linux;
  };
}