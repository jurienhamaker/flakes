{ config, lib, pkgs, user, secrets, impermanence, ... }:

{
  imports =
    [ (import ../../modules/desktop/hyprland/home.nix) ] ++
    [ (import ../../modules/scripts/home.nix) ] ++
    (import ../../modules/shell) ++
    (import ../../modules/editors) ++
    (import ../../modules/programs) ++
    (import ../../modules/theme);

  home = {
    username = "jurien";
    homeDirectory = "/home/jurien";
    file = {
      ".ssh/id_rsa.pub".source = ../../secrets/id_rsa.pub;
    };
  };

  home.activation.copySSHKey = lib.hm.dag.entryAfter ["writeBoundary"] ''
      install -D -m600 ${../../secrets/id_rsa} $HOME/.ssh/id_rsa
  '';

  home.activation.authorizedKeys = lib.hm.dag.entryAfter ["writeBoundary"] ''
      install -D -m600 ${../../secrets/id_rsa.pub} $HOME/.ssh/authorized_keys
  '';

  programs = {
    home-manager.enable = true;
  };

  home.stateVersion = "22.11";
}
