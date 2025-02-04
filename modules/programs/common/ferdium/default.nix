{ config, pkgs, ... }:
{
  home = {
    packages = with pkgs; [
      (pkgs.writeShellApplication {
        name = "ferdium";
        text = "${pkgs.ferdium}/bin/ferdium --use-gl=desktop";
      })
      (pkgs.makeDesktopItem {
        name = "ferdium";
        exec = "ferdium";
        desktopName = "Ferdium";
      })
    ];
  };
}