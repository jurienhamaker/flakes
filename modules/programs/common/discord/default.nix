{ config, pkgs, ... }:
{
  home = {
    packages = with pkgs; [
      discord
    ];
  };
  environment.systemPackages= with pkgs; [
    (pkgs.writeShellApplication {
      name = "discord";
      text = "${pkgs.discord}/bin/discord --use-gl=desktop";
    })
    (pkgs.makeDesktopItem {
      name = "discord";
      exec = "discord";
      desktopName = "Discord";
    })
  ]
}
