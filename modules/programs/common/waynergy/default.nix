{ config, pkgs, ... }:
{
  home = {
    packages = with pkgs; [
      waynergy
    ];
  };
}