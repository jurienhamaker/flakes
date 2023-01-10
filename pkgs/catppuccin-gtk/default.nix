{ lib, stdenv, fetchzip, pkgs, ... }:

stdenv.mkDerivation rec {
  pname = "cattpuccin-gtk";
  version = "0.2.7";

  src = fetchzip {
    url =
      "https://github.com/catppuccin/gtk/releases/download/v0.4.0/Catppuccin-Mocha-Standard-Lavender-Dark.zip";
    sha256 = "0k4psyikb9dcir7a7nw9byask55kc540zp92dhs4pamg22bhm2vm";
    stripRoot = false;
  };

  propagatedUserEnvPkgs = with pkgs; [
    gnome.gnome-themes-extra
    gtk-engine-murrine
  ];

  installPhase = ''
    mkdir -p $out/share/themes/
    cp -r Catppuccin-Frappe-Pink $out/share/themes
  '';

  meta = {
    description = "Soothing pastel theme for GTK3";
    homepage = "https://github.com/catppuccin/gtk";
    license = lib.licenses.gpl3;
    platforms = lib.platforms.unix;
    maintainers = [ lib.maintainers.Ruixi-rebirth ];
  };
}
