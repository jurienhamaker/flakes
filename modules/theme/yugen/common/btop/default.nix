{ config, pkgs, ... }:
{
  programs = {
    btop = {
      settings = {
        color_theme = "yugen";
      };
    };
  };
  home.file.".config/btop/themes/yugen.theme".source = ./theme.nix;
}
