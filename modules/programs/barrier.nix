{ config, pkgs, ... }:
{
  home = {
    packages = with pkgs; [
      barrier
    ];
  };
}
