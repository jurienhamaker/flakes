{ lib, stdenv, fetchzip, ... }:
stdenv.mkDerivation rec {
  pname = "cattpuccin-cursors-custom";
  version = "9999";
  src = fetchzip {
    url =
      "https://github.com/Ruixi-rebirth/Catppuccin-cursor/archive/refs/tags/1.0.zip";
    sha256 = "sha256-RCEVxeo3oBNqHogxWM/YqfPoQotirSQTMw15zCahWto=";
  };
  installPhase = ''
    mkdir -p $out/share/icons/Catppuccin-Frappe-Light
    cp -va index.theme cursors $out/share/icons/Catppuccin-Frappe-Light
  '';
  meta = {
    description = "Soothing pastel mouse cursors";
    homepage = "https://github.com/Ruixi-rebirth/Catppuccin-cursor";
    license = lib.licenses.gpl3;
    platforms = lib.platforms.unix;
    maintainers = [ lib.maintainers.Ruixi-rebirth ];
  };
}
