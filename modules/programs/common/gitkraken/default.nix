{ config, pkgs, ... }:
{
  home = {
    packages = with pkgs; [
      gitkraken
      (pkgs.writeShellApplication {
        name = "gitkraken";
        text = "${pkgs.gitkraken}/bin/gitkraken --use-gl=desktop";
      })
      (pkgs.makeDesktopItem {
        name = "gitkraken";
        exec = "gitkraken";
        desktopName = "GitKraken";
      })
    ];
  };
}