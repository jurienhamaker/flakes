{ pkgs, }:

{
  catppuccin-cursors = pkgs.callPackage ./catppuccin-cursors { };
  catppuccin-gtk = pkgs.callPackage ./catppuccin-gtk { };
  beekeeper-studio = pkgs.callPackage ./beekeeper-studio { };
  waynergy = pkgs.callPackage ./waynergy { };
}
