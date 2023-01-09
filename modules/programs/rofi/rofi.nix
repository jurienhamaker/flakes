{ lib, pkgs, user, ... }:
{
  home = {
    packages = with pkgs; [
      rofi-wayland
    ];
  };

  home.file.".config/rofi/scripts/rofi-bluetooth".source = ./scripts/rofi-bluetooth;
  home.file.".config/rofi/scripts/rofi-wifi-menu".source = ./scripts/rofi-wifi-menu;
  home.file.".config/rofi/scripts/rofi-power-menu".source = ./scripts/rofi-power-menu;

  home.file.".config/rofi/apps.rasi".source = ./apps.rasi;
  home.file.".config/rofi/bluetooth.rasi".source = ./bluetooth.rasi;
  home.file.".config/rofi/power-menu.rasi".source = ./power-menu.rasi;
  home.file.".config/rofi/wifi-menu.rasi".source = ./wifi-menu.rasi;
}
