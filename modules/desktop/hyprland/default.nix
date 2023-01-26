{ config, lib, pkgs, inputs, ... }:
{
  imports = [ ../../programs/waybar/hyprland_waybar.nix ];

  environment.systemPackages = with pkgs; [
    inputs.hypr-contrib.packages.${pkgs.system}.grimblast
    inputs.hyprpicker.packages.${pkgs.system}.hyprpicker
  ];
  programs.hyprland = {
    enable = true;
  };

  # Automatically on TTY login, see `../../shell/fish/fish.nix`

  security.pam.services.swaylock = { };
  security.pam.services.gnome-keyring.text = ''
    auth     optional    ${pkgs.gnome.gnome-keyring}/lib/security/pam_gnome_keyring.so
    session  optional    ${pkgs.gnome.gnome-keyring}/lib/security/pam_gnome_keyring.so auto_start

    password  optional    ${pkgs.gnome.gnome-keyring}/lib/security/pam_gnome_keyring.so
  '';

  xdg.portal = {
    enable = true;
    wlr.enable = true;
  };

}
