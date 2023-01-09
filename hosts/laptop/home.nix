{ config, lib, pkgs, user, secrets, impermanence, ... }:

{
  imports =
    # [ (import ../../modules/desktop/sway/home.nix) ] ++
    [ (import ../../modules/desktop/hyprland/home.nix) ] ++
    [ (import ../../modules/scripts/home.nix) ] ++
    (import ../../modules/shell) ++
    (import ../../modules/editors) ++
    (import ../../modules/programs) ++
    (import ../../modules/theme) ++
    (import ../../modules/devlop);

  home = {
    username = "jurien";
    homeDirectory = "/home/jurien";
    file = {
      ".ssh/id_rsa".text = secrets.jurien.sshKeys.private;
      ".ssh/id_rsa.pub".text = secrets.jurien.sshKeys.public;
    };
  };
  programs = {
    home-manager.enable = true;
  };

  home.stateVersion = "22.11";
}
