{ pkgs, }:

{
  catppuccin-cursors = pkgs.callPackage ./catppuccin-cursors { };
  catppuccin-gtk = pkgs.callPackage ./catppuccin-gtk { };
  beekeeper-studio = pkgs.callPackage ./beekeeper-studio { };
  # qq = pkgs.callPackage ./qq { };
  # netease-cloud-music-gtk = pkgs.callPackage ./netease-cloud-music-gtk { };
}
