{ config, pkgs, ... }:
{
  home = {
    packages = with pkgs; [
      mailspring
    ];
  };
  environment.systemPackages= with pkgs; [
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
}