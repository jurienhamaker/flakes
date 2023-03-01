{ config, pkgs, ... }:
{
  home = {
    packages = with pkgs; [
      mailspring
      (pkgs.writeShellApplication {
        name = "mailspring";
        text = "${pkgs.mailspring}/bin/mailspring --use-gl=desktop";
      })
      (pkgs.makeDesktopItem {
        name = "mailspring";
        exec = "mailspring";
        desktopName = "Mailspring";
      })
    ];
  };
}