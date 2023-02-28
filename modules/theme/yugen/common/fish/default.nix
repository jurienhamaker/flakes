{ lib, pkgs, user, ... }:

{
  home.file.".config/fish/conf.d/yugen.fish".text = import ./conf.d/yugen.nix;
}
