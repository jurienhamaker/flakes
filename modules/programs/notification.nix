{ config, pkgs, ... }:

{
  programs = {
    mako = {
      enable = true;
      font = "Iosevka Nerd Font 12";
      width = 256;
      height = 500;
      margin = "10";
      padding = "5";
      borderSize = 3;
      borderRadius = 3;
      backgroundColor = "#0a0a0a";
      borderColor = "#3d3d3d";
      progressColor = "over #302D41";
      textColor = "#0a0a0a";
      extraConfig = ''
        text-alignment=center
        [urgency=high]
        border-color=#3d3d3d
      '';
    };
  };
}
